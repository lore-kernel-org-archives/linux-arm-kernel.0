From: sumit.semwal@ti.com (Semwal, Sumit)
Date: Mon, 24 Jan 2011 11:20:57 +0530
Subject: [PATCH v9 18/18] OMAP2,3: DSS2: Get DSS IRQ from platform device
In-Reply-To: <20110123125216.GA29926@n2100.arm.linux.org.uk>
References: <1295690758-5845-1-git-send-email-sumit.semwal@ti.com>
	<1295690758-5845-19-git-send-email-sumit.semwal@ti.com>
	<4D3C217B.9020301@ru.mvista.com>
	<20110123125216.GA29926@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=zrLh5kaFUOsJvc1jyD5kcgw9NBRoT2zjB=2jy@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 23, 2011 at 6:22 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Jan 23, 2011 at 03:39:23PM +0300, Sergei Shtylyov wrote:
>>> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
>>> index 4d7a816..22690e9 100644
>>> --- a/drivers/video/omap2/dss/dss.c
>>> +++ b/drivers/video/omap2/dss/dss.c
>> [...]
>>> @@ -609,15 +609,18 @@ static int dss_init(bool skip_init)
>>> ? ? ?REG_FLD_MOD(DSS_CONTROL, 0, 2, 2); ? ? ?/* venc clock mode = normal */
>>> ? #endif
>>>
>>> - ? ?r = request_irq(INT_24XX_DSS_IRQ,
>>> + ? ?dss_irq = platform_get_irq(dss.pdev, 0);
>>> + ? ?if (dss_irq != -ENXIO) {
>>
>> ? ?Better just 'dss_irq > 0', IMHO.
>
> If a function returns negative error codes, the correct test is
> ? ? ? ?ret < 0
> not
> ? ? ? ?ret <= 0
>
> The fact that it happens to be dealing with IRQ numbers where IRQ0
> may not be valid is neither here nor there.
>
Thanks Sergei, Russell,

I will update this to check for (ret < 0) as the error case, and re-submit.
