From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 1 Jul 2013 16:48:53 +0900
Subject: [PATCH 01/04] ARM: shmobile: Use default ->init_irq() on EMEV2
In-Reply-To: <20130701073237.GU14567@verge.net.au>
References: <20130701060103.21728.83833.sendpatchset@w520>
 <20130701060112.21728.37189.sendpatchset@w520>
 <20130701073237.GU14567@verge.net.au>
Message-ID: <CANqRtoSJ=Vmvz9OdJQzgMZ8y2qyVUh3PivXhUVVGaxaurZNu2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon, Maxime, everyone,

On Mon, Jul 1, 2013 at 4:32 PM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Jul 01, 2013 at 03:01:12PM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> Remove redundant irqchip_init() callback. The default case
>> of NULL will result in invoking irqchip_init() anyway.
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>> ---
>>
>>  arch/arm/mach-shmobile/setup-emev2.c |    2 --
>>  1 file changed, 2 deletions(-)
>>
>> --- 0005/arch/arm/mach-shmobile/setup-emev2.c
>> +++ work/arch/arm/mach-shmobile/setup-emev2.c 2013-07-01 13:33:39.000000000 +0900
>> @@ -20,7 +20,6 @@
>>  #include <linux/init.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/irq.h>
>> -#include <linux/irqchip.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/platform_data/gpio-em.h>
>>  #include <linux/of_platform.h>
>> @@ -445,7 +444,6 @@ DT_MACHINE_START(EMEV2_DT, "Generic Emma
>>       .smp            = smp_ops(emev2_smp_ops),
>>       .init_early     = emev2_init_delay,
>>       .nr_irqs        = NR_IRQS_LEGACY,
>> -     .init_irq       = irqchip_init,
>>       .dt_compat      = emev2_boards_compat_dt,
>>  MACHINE_END
>
> Hi Magnus,
>
> I mistakenly dropped the following patch from Maxime Ripard from
> v3.11. I have re-queued it up, for v3.12, in the cleanup branch:
>
> commit 4042de1229ecf083890d8ad5c9327e03b648c1a2
> Author: Maxime Ripard <maxime.ripard@free-electrons.com>
> Date:   Sun May 26 22:05:23 2013 +0900
>
>     ARM: shmobile: emev2: Remove init_irq declaration in machine description

Thanks for going through earlier submitted patches and picking them
up. Of course I welcome the contribution by Maxime so please use his
code over mine wherever possible.

Cheers,

/ magnus
