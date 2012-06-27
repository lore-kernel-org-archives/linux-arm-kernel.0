From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 27 Jun 2012 20:40:18 +0200
Subject: [RFC PATCHv1 1/2] ARM: socfpga: initial support for Altera's
 SOCFPGA platform.
In-Reply-To: <20120627180516.GA17393@elf.ucw.cz>
References: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
 <1340805007-3313-2-git-send-email-dinguyen@altera.com>
 <20120627162014.1494cdd7@skate> <20120627180516.GA17393@elf.ucw.cz>
Message-ID: <20120627204018.0bfef362@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Wed, 27 Jun 2012 20:05:16 +0200,
Pavel Machek <pavel@denx.de> a ?crit :

> > Is SOCFPGA a good name? It seems like a very generic name. Shouldn't it
> > be ARCH_ALTERA_SOCFPGA a better name? I suspect other vendors will
> > provide a SoC together with a FPGA.
> 
> I guess for config option name, ALTERA_SOCFPGA is okay, but for
> directory name it would be a little bit long. Would that work?

Hum, yes, maybe. Maybe just MACH_ALTERA, and mach-altera then?
Hopefully others will have better ideas.

> > And even more: for a given SoC
> > variant, we now generally only want one config options, the board-level
> > details being abstracted out by the device tree.
> 
> Will look into that later.

Ok. If you look at other platforms, they now typically have only one
DT_MACHINE_START, and one configuration option associated to it, for
each SoC variant. The different boards are only described using DT.

> Ok.
> 
> arch/arm/mach-socfpga/socfpga_cyclone5.c:119: error:
> 'IRQ_SOCFPGA_L4_OSC1_TIMER0' undeclared (first use in this function)
> 
> Looks like we'll meed a bit more of dt :-).

Yes, you need more DT. You need a DT node for the timer, which will
contain all the details like base I/O address and IRQ.

> > > +#define NR_IRQS			512
> > 
> > You should be looking at using SPARSE_IRQ to avoid having a maximum
> > number of irqs. See for example mach-highbank/.
> 
> Is maximum number of interrupts a problem? 512 does not seem
> excessive.

Regardless of the value of NR_IRQS, there is apparently a trend to use
SPARSE_IRQ anyway. However, I am not at the best place to explain why
SPARSE_IRQ is now considered the right thing to use.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
