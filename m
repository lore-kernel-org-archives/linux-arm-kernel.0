From: bryan.wu@canonical.com (Bryan Wu)
Date: Wed, 1 Jun 2011 16:26:46 +0800
Subject: [RFC] Consolidation: Replace all led drivers in arch/arm to leds
	trigger drivers
In-Reply-To: <BANLkTikZ4bo8_MO68SZSyAeFdZVLJkAnkw@mail.gmail.com>
References: <BANLkTimRM=Uq6FUN-tvGrf3HLN3BUYqmOQ@mail.gmail.com>
	<BANLkTikZ4bo8_MO68SZSyAeFdZVLJkAnkw@mail.gmail.com>
Message-ID: <BANLkTikBu2eiZ=ugotLgFMb=L5VUB3JbcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 1, 2011 at 4:00 PM, Andrew Victor <avictor.za@gmail.com> wrote:
> hi Bryan,
>
>> arch/arm/mach-at91/leds.c
>
> That file also has common initialization & registration code for the
> "leds-gpio" and "leds-atmel-pwm" devices, but the old CONFIG_LEDS
> section can be dropped.
>

I'm not sure about dropping CONFIG_LEDS section here, since I found
~10 boards in mach-at91 are using it.
Cscope tag: at91_init_leds
   #   line  filename / context / line
   1     59  arch/arm/mach-at91/board-cap9adk.c <<cap9adk_init_early>>
             at91_init_leds(AT91_PIN_PA10, AT91_PIN_PA11);
   2     52  arch/arm/mach-at91/board-csb337.c <<csb337_init_early>>
             at91_init_leds(AT91_PIN_PB0, AT91_PIN_PB1);
   3     55  arch/arm/mach-at91/board-ecbat91.c <<ecb_at91init_early>>
             at91_init_leds(AT91_PIN_PC7, AT91_PIN_PC7);
   4     41  arch/arm/mach-at91/board-eco920.c <<eco920_init_early>>
             at91_init_leds(AT91_PIN_PB0, AT91_PIN_PB1);
   5     52  arch/arm/mach-at91/board-kafa.c <<kafa_init_early>>
             at91_init_leds(AT91_PIN_PB4, AT91_PIN_PB4);
   6     54  arch/arm/mach-at91/board-kb9202.c <<kb9202_init_early>>
             at91_init_leds(AT91_PIN_PC19, AT91_PIN_PC18);
   7     54  arch/arm/mach-at91/board-rm9200dk.c <<dk_init_early>>
             at91_init_leds(AT91_PIN_PB2, AT91_PIN_PB2);
   8     54  arch/arm/mach-at91/board-rm9200ek.c <<ek_init_early>>
             at91_init_leds(AT91_PIN_PB1, AT91_PIN_PB2);
   9     53  arch/arm/mach-at91/board-sam9-l9260.c <<ek_init_early>>
             at91_init_leds(AT91_PIN_PA9, AT91_PIN_PA6);
  10     63  arch/arm/mach-at91/board-sam9261ek.c <<ek_init_early>>
             at91_init_leds(AT91_PIN_PA13, AT91_PIN_PA14);
  11     62  arch/arm/mach-at91/board-yl-9200.c <<yl9200_init_early>>
             at91_init_leds(AT91_PIN_PB16, AT91_PIN_PB17);
  12    203  arch/arm/mach-at91/include/mach/board.h <<defined>>
             extern void __init at91_init_leds(u8 cpu_led, u8 timer_led);

If you guys think it is useless, I can post patch to remove them.

Thanks,
-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
