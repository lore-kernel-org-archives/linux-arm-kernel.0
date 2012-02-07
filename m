From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 7 Feb 2012 20:43:40 +0100
Subject: [RFC PATCH 09/11] Cortex-M3: Allow the building of Cortex-M3
 kernel port
In-Reply-To: <CAHXqBF+z291NEEph6hcmhLoxE=D-tTO0=n8B-sfJrmFiYGU9mQ@mail.gmail.com>
References: <20120122111230.GB14835@pengutronix.de>
 <1327230817-12855-9-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAHXqBF+z291NEEph6hcmhLoxE=D-tTO0=n8B-sfJrmFiYGU9mQ@mail.gmail.com>
Message-ID: <20120207194340.GE8621@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 22, 2012 at 09:05:44PM +0100, Micha? Miros?aw wrote:
> 2012/1/22 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> [...]
> > --- a/arch/arm/kernel/Makefile
> > +++ b/arch/arm/kernel/Makefile
> > @@ -13,10 +13,16 @@ CFLAGS_REMOVE_return_address.o = -pg
> >
> > ?# Object file lists.
> >
> > -obj-y ? ? ? ? ?:= elf.o entry-armv.o entry-common.o irq.o opcodes.o \
> > +obj-y ? ? ? ? ?:= elf.o entry-common.o irq.o opcodes.o \
> > ? ? ? ? ? ? ? ? ? process.o ptrace.o return_address.o setup.o signal.o \
> > ? ? ? ? ? ? ? ? ? sys_arm.o stacktrace.o time.o traps.o
> >
> > +ifeq ($(CONFIG_CPU_V7M),y)
> > +obj-y ? ? ? ? ?+= entry-v7m.o
> > +else
> > +obj-y ? ? ? ? ?+= entry-armv.o
> > +endif
> > +
> 
> Maybe something shorter, like this? '-)
> 
> obj-$(CONFIG_CPU_V7M) += entry-v7m.o
> obj-$(if $(CONFIG_CPU_V7M),,y) += entry-armv.o
It's shorter, but for readability I prefer my version.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
