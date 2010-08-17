From: kevin.wells@nxp.com (Kevin Wells)
Date: Wed, 18 Aug 2010 01:04:38 +0200
Subject: [PATCH 1/2] video: amba_clcd: Fix driver clock enable/disable
	balance issues
In-Reply-To: <20100817211740.GE20325@n2100.arm.linux.org.uk>
References: <1281567784-12684-1-git-send-email-wellsk40@gmail.com>
	<1281567784-12684-2-git-send-email-wellsk40@gmail.com>
	<20100817211740.GE20325@n2100.arm.linux.org.uk>
Message-ID: <083DF309106F364B939360100EC290F80ACF617DEB@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> On Wed, Aug 11, 2010 at 04:03:03PM -0700, wellsk40 at gmail.com wrote:
> > From: Kevin Wells <wellsk40@gmail.com>
> >
> > The amba clcd clock enable and disable calls can become unbalanced.
> > This usually occurs on the first call to clcdfb_set_par() during
> > LCD init, but can also occur when the LCD enters and exits blank
> > state. This fix prevents clk_disable() from being called until
> > clk_enable() has been called first.
> >
> > Signed-off-by: Kevin Wells <wellsk40@gmail.com>
> 
> Not quite the right way to do things, because this makes yourself the
> author of the patch which is obviously wrong.
> 
> I'll commit it myself now, as I'm about to send stuff to Linus.  I'm
> going to assume you've tested it, but as I don't know positively I
> can't add an attributation for it.
> 

Thanks for checking that in.
Sorry - I had sent another mail earlier a few weeks ago asking if you
wanted to check in that change (patch 1), but I think it got lost in
the shuffle.

Both patches are tested. You can add a "Tested by" from me if it's not
too late.
