From: miltonm@bga.com (Milton Miller)
Date: Fri, 16 Jul 2010 11:23:55 -0500
Subject: [PATCH] Stop ARM boards crashing when CUPS is loaded - 2.6.35-rc5
In-Reply-To: <4C402746.6080309@canonical.com>
References: <4C3C72C6.4000005@canonical.com>
	<20100715130214.4c9303b2.akpm@linux-foundation.org>
	<20100715200618.GA6773@n2100.arm.linux.org.uk>
	<4C40218A.4090806@canonical.com>
	<20100716092018.GB16995@n2100.arm.linux.org.uk>
Message-ID: <miltonm-arm-parport-1@bga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri Jul 16 2010 about 05:33:06 EST,  Lee Jones wrote:
> > The best solution is probably for the parport code to go through a
> > modernisation cycle like the serial code did, essentially using
> > platform devices to pass the base addresses. This would make the
> > driver more portable, and eliminates this problem entirely (because
> > platforms which don't have parports won't register the platform device(s)
> > necessary for parport to even probe illegal addresses.)
> 
> This sounds brilliant - when are you going to start? </kidding>

It has a long time ago ...

drivers/parport/parport_pc.c calls parport_pc_find_nonpci_ports,
which is in asm/parport.h

> 
> In all seriousness, do you think anyone is likely to undertake this
> work anytime soon? I am seeing this problem in a distribution which
> is due for release in October. I have no problem implementing a config
> change in the meantime, but as you say, a more _correct_ and portable
> solution should be sought.

Why not replace the arm asm/parport.h with asm-generic/parport.h which
already has a check for CONFIG_ISA, which appears to only be selected
on a few ARM platforms?

milton
