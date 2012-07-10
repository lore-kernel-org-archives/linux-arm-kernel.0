From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 10 Jul 2012 14:20:33 +0200
Subject: Move designware timer OF glue into drivers/clocksource
In-Reply-To: <20120710094249.GF10225@elf.ucw.cz>
References: <20120710094249.GF10225@elf.ucw.cz>
Message-ID: <20120710142033.2786c434@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tue, 10 Jul 2012 11:42:50 +0200,
Pavel Machek <pavel@denx.de> a ?crit :

> It seems mach-socfpga (not yet in tree, we are trying to merge it)
> would need pretty much direct copy of arch/arm/mach-picoxcell/time.c
> ... And because "just copying" it seems like quite bad idea, what
> about this, instead?

Of course, the idea sounds good. A few comments:

 * Is a new file really needed? Wouldn't it be better to just add a
   device tree binding to the existing dw_apb_timer driver?

 * You're moving arch/arm/mach-picoxcell/time.c, but not updating any
   mach-picoxcell Makefile, so I presume this would break the build.

 * I'm not a big fan of the ../../../drivers/clocksource/...o in your
   Makefile. What about using an hidden kconfig option in
   drivers/clocksource/ that gets selected by your architecture, so
   that the driver gets build? This is typically done for a few other
   timer drivers in drivers/clocksource already.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
