From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 28 May 2013 14:53:04 +0900
Subject: [PATCH 2/9] ARM: shmobile: add GPIO IRQ macro
In-Reply-To: <20130528040729.GN13532@quad.lixom.net>
References: <1369648773-7941-1-git-send-email-horms+renesas@verge.net.au>
 <1369648773-7941-3-git-send-email-horms+renesas@verge.net.au>
 <20130528040729.GN13532@quad.lixom.net>
Message-ID: <CANqRtoTUyaqfK3Droq3EuMZy-p2gzzTtcSTp=wiSM-3j0f4+Dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Tue, May 28, 2013 at 1:07 PM, Olof Johansson <olof@lixom.net> wrote:
> On Mon, May 27, 2013 at 06:59:26PM +0900, Simon Horman wrote:
>> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>
>> R-Car series gpio_rcar driver can control GPIO IRQ today.
>> It needs base IRQ number for gpio_rcar_config :: .irq_base
>> This patch adds macro for GPIO IRQ.
>> This patch was tested on Bock-W board
>>
>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>> ---
>>  arch/arm/mach-shmobile/include/mach/irqs.h |    5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/mach-shmobile/include/mach/irqs.h b/arch/arm/mach-shmobile/include/mach/irqs.h
>> index b2074e2..d241bfd 100644
>> --- a/arch/arm/mach-shmobile/include/mach/irqs.h
>> +++ b/arch/arm/mach-shmobile/include/mach/irqs.h
>> @@ -16,4 +16,9 @@
>>  #define IRQPIN_BASE          2000
>>  #define irq_pin(nr)          ((nr) + IRQPIN_BASE)
>>
>> +/* GPIO IRQ */
>> +#define _GPIO_IRQ_BASE               2500
>> +#define GPIO_IRQ_BASE(x)     (_GPIO_IRQ_BASE + (32 * x))
>> +#define GPIO_IRQ(x, y)               (_GPIO_IRQ_BASE + (32 * x) + y)
>> +
>>  #endif /* __ASM_MACH_IRQS_H */
>
> Hmm. It'd be real nice to see some effort on moving this over to sparse
> irq instead. That'll be needed for full device tree conversion anyway. And
> with that, the static irq bases will be gone, so drivers and some of
> the platform code will need to be adjusted accordingly.

I believe we've been doing sparse IRQ for ages, this is just to make
non-DT stuff more readable.

Or was there some particular other interface you wanted us to use for
non-DT board code?

Cheers,

/ magnus
