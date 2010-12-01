From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Wed, 1 Dec 2010 16:05:08 +0100 (CET)
Subject: [PATCH] ARM: Gemini: Add support for PCI Bus
In-Reply-To: <201011301719.03202.arnd@arndb.de>
References: <1290263224-16965-1-git-send-email-ulli.kroll@googlemail.com>
	<201011291657.53316.arnd@arndb.de>
	<20101130160527.GB2377@n2100.arm.linux.org.uk>
	<201011301719.03202.arnd@arndb.de>
Message-ID: <alpine.LNX.2.00.1012011604510.8521@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tue, 30 Nov 2010, Arnd Bergmann wrote:

> On Tuesday 30 November 2010, Russell King - ARM Linux wrote:
> > No, the above is correct.  What I was talking about was the difference
> > between these:
> > 
> > config PCI
> >         bool "PCI support" if MIGHT_HAVE_PCI
> > 
> > and
> > 
> > config PCI
> >         bool "PCI support"
> >         depends on MIGHT_HAVE_PCI
> > 
> > In the first instance, PCI itself does not depend on MIGHT_HAVE_PCI.
> > MIGHT_HAVE_PCI controls whether the user is offered the "PCI support"
> > option.
> > 
> > In the second instance, PCI depends on MIGHT_HAVE_PCI, which must be
> > set to 'y' to offer the option and also if PCI is selected.
> 
> Right, I misread the patch as doing the wrong thing, thanks for
> clearing that up.
> 
> > We want the first behaviour.  Platforms which must have PCI support can
> > continue to select PCI as they currently do, and leave the MIGHT_HAVE_PCI
> > option alone.
> > 
> > Platforms which may optionally have PCI support should select
> > MIGHT_HAVE_PCI instead.
> 
> Yes, that sounds good.
> 
> 	Arnd
> 

OK.
I prepare some patch.

Ulli
