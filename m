From: pavel@denx.de (Pavel Machek)
Date: Tue, 26 May 2015 23:56:17 +0200
Subject: [PATCH v4 1/2] ARM: socfpga: support suspend to ram
In-Reply-To: <alpine.DEB.2.02.1505261638190.19205@linuxheads99>
References: <1432317735-29413-1-git-send-email-atull@opensource.altera.com>
 <1432317735-29413-2-git-send-email-atull@opensource.altera.com>
 <20150525124133.GF9943@amd>
 <alpine.DEB.2.02.1505261638190.19205@linuxheads99>
Message-ID: <20150526215617.GA3137@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Thanks for the feedback.
> 
> Yes I agree.
> 
> One possibility is that I could add a suspend function to EDAC that
> always fails with a helpful message like "Suspend with EDAC not
> supported."  If someone wants to suspend, they'll have to take the
> EDAC out of the device tree so its probe will bomb out.  I'm not
> sure how normal it is to have suspend functions in the kernel
> that always fail, though.

"Interesting" solution, but better than config exclusion, I'd say.

> > > +	/*
> > > +	 * This code assumes that the bootloader has already
> > > +	 * properly configured the sdram controller:
> > 
> > Which bootloaders can do that? 
> 
> Whatever bootloader is configuring the sdram controller for the
> board.

Ok, so direct question: will mainline u-boot 2015.04 configure the
controller correctly?

> > > +	 * sdr.ctrlcfg.lowpwreq.selfrfshmask = 3
> > > +	 * sdr.ctrlcfg.lowpwrtiming.clkdisablecycles = 8
> > > +	 * sdr.ctrlcfg.dramtiming4.selfrfshexit = 512
> > 
> > Would it make sense to configure it in Linux?
> 
> The bootloader is responsible for configuring the sdram
> controller with parameters appropriate for whatever vendor's DDR
> is on the board, so that's where this must go.
> 
> Now I realize I should make this message more general, since it is
> true for the socfpga cyclone5 devkit, but may need to be adjusted
> for other boards.

Aha, ok, the comment really needs to be fixed.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
