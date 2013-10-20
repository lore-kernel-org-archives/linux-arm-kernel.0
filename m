From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 20 Oct 2013 10:42:01 +0200
Subject: [PATCH 1/4] cpufreq: Add a cpufreq driver for Marvell Dove
In-Reply-To: <20131019230908.GA10934@w500.lan>
References: <1382186261-14482-1-git-send-email-andrew@lunn.ch>
 <1382186261-14482-2-git-send-email-andrew@lunn.ch>
 <20131019230908.GA10934@w500.lan>
Message-ID: <20131020084201.GA19257@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 20, 2013 at 01:09:08AM +0200, Luka Perkov wrote:
> Hi Andrew,
> 
> On Sat, Oct 19, 2013 at 02:37:38PM +0200, Andrew Lunn wrote:
> > The Marvell Dove SoC can run the CPU at two frequencies. The high
> > frequencey is from a PLL, while the lower is the same as the DDR
> > clock. Add a cpufreq driver to swap between these frequences.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  drivers/cpufreq/Kconfig.arm    |   7 ++
> >  drivers/cpufreq/Makefile       |   1 +
> >  drivers/cpufreq/dove-cpufreq.c | 276 +++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 284 insertions(+)
> >  create mode 100644 drivers/cpufreq/dove-cpufreq.c
> 
> ...
> 
> > --- /dev/null
> > +++ b/drivers/cpufreq/dove-cpufreq.c
> > @@ -0,0 +1,276 @@
> > +/*
> > + *	dove_freq.c: cpufreq driver for the Marvell dove
> > + *
> > + *	Copyright (C) 2013 Andrew Lunn <andrew@lunn.ch>
> > + *
> > + *	This program is free software; you can redistribute it and/or
> > + *	modify it under the terms of the GNU General Public License
> > + *	as published by the Free Software Foundation; either version
> > + *	2 of the License, or (at your option) any later version.
> > + */
> > +
> > +#define DEBUG
> 
> It seems to me that this define is not used at all...

Hi Luke

Correct. Its left over from my debugging. I will collect more comments
and then remove it in a v2 patchset.

    Thanks
	Andrew
