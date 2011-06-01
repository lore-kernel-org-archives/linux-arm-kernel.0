From: avictor.za@gmail.com (Andrew Victor)
Date: Wed, 1 Jun 2011 10:00:47 +0200
Subject: [RFC] Consolidation: Replace all led drivers in arch/arm to leds
	trigger drivers
In-Reply-To: <BANLkTimRM=Uq6FUN-tvGrf3HLN3BUYqmOQ@mail.gmail.com>
References: <BANLkTimRM=Uq6FUN-tvGrf3HLN3BUYqmOQ@mail.gmail.com>
Message-ID: <BANLkTikZ4bo8_MO68SZSyAeFdZVLJkAnkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Bryan,

> arch/arm/mach-at91/leds.c

That file also has common initialization & registration code for the
"leds-gpio" and "leds-atmel-pwm" devices, but the old CONFIG_LEDS
section can be dropped.


> Or we can just delete some leds driver such as
> arch/arm/mach-ks8695/leds.c, since nobody is using that driver in
> ks8695.

That file can be deleted, and also drop the ks8695_init_leds() from
arch/arm/mach-ks8695/devices.c.


Regards,
  Andrew Victor
