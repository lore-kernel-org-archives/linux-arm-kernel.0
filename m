From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 3 Jun 2013 18:06:05 +0800
Subject: [PATCH v3 02/11] irqchip: mmp: support irqchip
In-Reply-To: <20130603094200.GH18614@n2100.arm.linux.org.uk>
References: <1370251845-31373-1-git-send-email-haojian.zhuang@gmail.com>
 <1370251845-31373-3-git-send-email-haojian.zhuang@gmail.com>
 <20130603094200.GH18614@n2100.arm.linux.org.uk>
Message-ID: <CAN1soZxWDGit540wZvxUDMDCUO_BTZnBLXrMKU4NAYeaEfe7BA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 3, 2013 at 5:42 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jun 03, 2013 at 05:30:36PM +0800, Haojian Zhuang wrote:
>> @@ -64,7 +60,7 @@ static const char *mmp_dt_board_compat[] __initdata = {
>>
>>  DT_MACHINE_START(PXA168_DT, "Marvell PXA168 (Device Tree Support)")
>>       .map_io         = mmp_map_io,
>> -     .init_irq       = mmp_dt_irq_init,
>> +     .init_irq       = irqchip_init,
>>       .init_time      = mmp_dt_init_timer,
>>       .init_machine   = pxa168_dt_init,
>>       .dt_compat      = mmp_dt_board_compat,
>> @@ -72,7 +68,7 @@ MACHINE_END
>>
>>  DT_MACHINE_START(PXA910_DT, "Marvell PXA910 (Device Tree Support)")
>>       .map_io         = mmp_map_io,
>> -     .init_irq       = mmp_dt_irq_init,
>> +     .init_irq       = irqchip_init,
>
> This is what's in linux-next:
>
> void __init init_IRQ(void)
> {
>         if (IS_ENABLED(CONFIG_OF) && !machine_desc->init_irq)
>                 irqchip_init();
>         else
>                 machine_desc->init_irq();
> }
>
> So just set your .init_irq to NULL after basing your patchset on
> ebafed7ab9b637656b685f1dc1ee528c77241a0d (ARM: irq: Call irqchip_init
> if no init_irq function is specified).

OK. I'll update it.

Regards
Haojian
