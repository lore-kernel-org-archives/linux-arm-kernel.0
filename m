From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Mon, 24 May 2010 22:29:01 +0300
Subject: [PATCH v3 11/14] omap: mailbox: only compile for configured archs
In-Reply-To: <20100524.174205.22049047.Hiroshi.DOYU@nokia.com>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
	<1274548465-20208-12-git-send-email-felipe.contreras@gmail.com>
	<20100524.174205.22049047.Hiroshi.DOYU@nokia.com>
Message-ID: <AANLkTim7Jxlx3Owyn2IM_TjUWxS72I7h9H5d0evbCsVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 24, 2010 at 5:42 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
> From: ext Felipe Contreras <felipe.contreras@gmail.com>

>> +     if (false);
>
> nitpcik:
> The above may look better as below:
>
> ? ? ? ?if (false)
> ? ? ? ? ? ? ? ?;
>
> "checkpatch.pl" also doesn't complain.

Personally I think it looks weird and it's a checkpatch bug, but fine by me.

>> +#if defined(CONFIG_ARCH_OMAP3430)
>> + ? ? else if (cpu_is_omap3430()) {
>> ? ? ? ? ? ? ? list = omap3_mboxes;
>>
>> ? ? ? ? ? ? ? list[0]->irq = platform_get_irq_byname(pdev, "dsp");
>> ? ? ? }
>> +#endif
>> ?#if defined(CONFIG_ARCH_OMAP2420)
>> ? ? ? else if (cpu_is_omap2420()) {
>> ? ? ? ? ? ? ? list = omap2_mboxes;
>> @@ -407,12 +415,14 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
>> ? ? ? ? ? ? ? list[1]->irq = platform_get_irq_byname(pdev, "iva");
>> ? ? ? }
>> ?#endif
>> +#if defined(CONFIG_ARCH_OMAP4)
>> ? ? ? else if (cpu_is_omap44xx()) {
>> ? ? ? ? ? ? ? list = omap4_mboxes;
>>
>> ? ? ? ? ? ? ? list[0]->irq = list[1]->irq =
>> ? ? ? ? ? ? ? ? ? ? ? platform_get_irq_byname(pdev, "mbox");
>
> For checkpatch.pl,
>
> ? ? ? ? ? ? ? ?list[0]->irq =
> ? ? ? ? ? ? ? ? ? ? ? ?platform_get_irq_byname(pdev, "mbox");
> ? ? ? ? ? ? ? ?list[1]->irq = list[0]->irq;

I don't see checkpatch (0.30) complaining about that.

Cheers.

-- 
Felipe Contreras
