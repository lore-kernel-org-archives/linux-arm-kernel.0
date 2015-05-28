From: atull@opensource.altera.com (atull)
Date: Thu, 28 May 2015 15:21:43 -0500
Subject: [PATCH v4 1/2] ARM: socfpga: support suspend to ram
In-Reply-To: <20150526215617.GA3137@amd>
References: <1432317735-29413-1-git-send-email-atull@opensource.altera.com>
 <1432317735-29413-2-git-send-email-atull@opensource.altera.com>
 <20150525124133.GF9943@amd>
 <alpine.DEB.2.02.1505261638190.19205@linuxheads99>
 <20150526215617.GA3137@amd>
Message-ID: <alpine.DEB.2.02.1505281520410.31038@linuxheads99>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 May 2015, Pavel Machek wrote:

> Hi!
> 
> > Thanks for the feedback.
> > 
> > Yes I agree.
> > 
> > One possibility is that I could add a suspend function to EDAC that
> > always fails with a helpful message like "Suspend with EDAC not
> > supported."  If someone wants to suspend, they'll have to take the
> > EDAC out of the device tree so its probe will bomb out.  I'm not
> > sure how normal it is to have suspend functions in the kernel
> > that always fail, though.
> 
> "Interesting" solution, but better than config exclusion, I'd say.
> 
> > > > +	/*
> > > > +	 * This code assumes that the bootloader has already
> > > > +	 * properly configured the sdram controller:
> > > 
> > > Which bootloaders can do that? 
> > 
> > Whatever bootloader is configuring the sdram controller for the
> > board.
> 
> Ok, so direct question: will mainline u-boot 2015.04 configure the
> controller correctly?

Should be in 2015.07

Alan Tull
