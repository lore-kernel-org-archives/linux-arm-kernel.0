From: ming.lei@canonical.com (Ming Lei)
Date: Fri, 25 Nov 2011 08:37:05 +0800
Subject: [PATCH v5 6/7] arm: omap4: support pmu
In-Reply-To: <CAH+eYFD==CbcTWha=4pLVaaeE32gN4_BPdKv0Eo-XNhiz8CM-g@mail.gmail.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
 <1319467559-5518-7-git-send-email-ming.lei@canonical.com>
 <CAH+eYFD==CbcTWha=4pLVaaeE32gN4_BPdKv0Eo-XNhiz8CM-g@mail.gmail.com>
Message-ID: <CACVXFVPE0pt2shERtAvn9bU2Mtg_xcuV0g3agexxPRYRHpfZvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 24, 2011 at 1:47 AM, Rabin Vincent <rabin@rab.in> wrote:
> On Mon, Oct 24, 2011 at 20:15, ?<ming.lei@canonical.com> wrote:
>> ?static struct platform_device* __init omap4_init_pmu(void)
>> ?{
>> ? ? ? ?int id = -1;
>> @@ -420,6 +472,10 @@ static struct platform_device* __init omap4_init_pmu(void)
>> ? ? ? ? ? ? ? ?return NULL;
>> ? ? ? ?}
>>
>> + ? ? ? omap4_pmu_data.handle_irq = omap4_pmu_handler;
>> + ? ? ? omap4_pmu_data.enable_irq = omap4_enable_cti;
>> + ? ? ? omap4_pmu_data.disable_irq = omap4_disable_cti;
>> +
>> ? ? ? ?pd = omap_device_build_ss(dev_name, id, oh, 3, &omap4_pmu_data,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?sizeof(omap4_pmu_data),
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?omap_pmu_latency,
>> @@ -440,7 +496,9 @@ static void __init omap_init_pmu(void)
>> ? ? ? ? ? ? ? ?pd = omap4_init_pmu();
>> ? ? ? ? ? ? ? ?if (!pd)
>> ? ? ? ? ? ? ? ? ? ? ? ?return;
>> - ? ? ? ? ? ? ? omap_device_enable(pd);
>> +
>> + ? ? ? ? ? ? ? omap_device_enable(&od->pdev);
>> + ? ? ? ? ? ? ? omap4_configure_pmu_irq();
>
> This doesn't build, because there's no "od" in this function. ?I guess
> you shouldn't be changing the omap_device_enable() call.

Yes, you are right. Looks like this version is against linus tree, and
I have another version against -next tree, which uses the latest
'debugss' module and will be sent out later.


thanks,
--
Ming Lei
