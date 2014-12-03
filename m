From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Dec 2014 10:50:17 +0100
Subject: [PATCH v3 5/5] tty/serial: Add Spreadtrum sc9836-uart driver
 support
In-Reply-To: <CAAfSe-u+g0mYGi9Adrd+YwwZ=q0-s79yCg_paB1UAVqFoufXEA@mail.gmail.com>
References: <1416917818-10506-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <54761BFC.4020705@ti.com>
 <CAAfSe-u+g0mYGi9Adrd+YwwZ=q0-s79yCg_paB1UAVqFoufXEA@mail.gmail.com>
Message-ID: <3212776.kDbe7yX4eX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 December 2014 17:17:13 Lyra Zhang wrote:

> 2014-11-27 2:29 GMT+08:00 Murali Karicheri <m-karicheri2@ti.com>:
> > How about sorting this includes? asm/irq.h go first followed linux/ in alphabatical order?
>
> There are a few compile warnings if I moved asm/irq.h to the top of
> all included files.

The order that Murali meant is

- first all linux/*.h headers, sorted alphabetically
- then all asm/*.h headers, again sorted alphabetically

This is the recommended style in general.

> Warning details are below:
> 
> In file included from drivers/tty/serial/sprd_serial.c:14:0:
> ./arch/arm64/include/asm/irq.h:6:39: warning: ?struct pt_regs?
> declared inside parameter list [enabled by default]
>  extern void (*handle_arch_irq)(struct pt_regs *);
>                                        ^
> ./arch/arm64/include/asm/irq.h:6:39: warning: its scope is only this
> definition or declaration, which is probably not what you want
> [enabled by default]
> ./arch/arm64/include/asm/irq.h:8:54: warning: ?struct pt_regs?
> declared inside parameter list [enabled by default]
>  extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
> 

I would consider this a (minor) bug in asm/irq.h. If you don't mind,
please submit a patch to add a line with 'struct pt_regs;' to
asm/irq.h.

	Arnd
