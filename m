From: ithamar.adema@team-embedded.nl (Ithamar R. Adema)
Date: Thu, 17 Mar 2011 23:29:12 +0100
Subject: [PATCH 3/9] lpc2k: clk API
In-Reply-To: <083DF309106F364B939360100EC290F80B15AC2B3E@eu1rdcrdc1wx030.exi.nxp.com>
References: <1300377264-10843-1-git-send-email-ithamar.adema@team-embedded.nl>
	<1300377264-10843-4-git-send-email-ithamar.adema@team-embedded.nl>
	<083DF309106F364B939360100EC290F80B15AC2B3E@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <1300400952.2138.109.camel@team-embedded-2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Thu, 2011-03-17 at 23:16 +0100, Kevin Wells wrote:
> > diff --git a/arch/arm/mach-lpc2k/include/mach/regs-clock.h
> > b/arch/arm/mach-lpc2k/include/mach/regs-clock.h
> > new file mode 100644
> > index 0000000..1c94582
> > --- /dev/null
> > +++ b/arch/arm/mach-lpc2k/include/mach/regs-clock.h
> > @@ -0,0 +1,36 @@
> > +/*
> > + * Copyright 2011 Team Embedded VOF
> > + *     Ithamar R. Adema <ihamar.adema@team-embedded.nl>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#ifndef MACH_LPC2K_REGS_CLOCK_H
> > +#define MACH_LPC2K_REGS_CLOCK_H
> > +
> > +#define CLKSRCSEL	0x10c
> > +#define CLKSRC(x)	((x) & 3)
> > +#define PLLCON		0x080
> > +#define PLLCFG		0x084
> > +#define PLLSTAT		0x088
> > +#define M(x)		(((x) & 0x7fff) + 1)
> > +#define N(x)		((((x) >> 16) & 0xf) + 1)
> 
> N has a field size of 8 bits? Mask should be 0xff

Ouch, will fix for v2 of this patchset!

Ithamar.
