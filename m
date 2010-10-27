From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 27 Oct 2010 11:22:53 +0100
Subject: [PATCH] ARM: imx: Add some core definitions for MX53
In-Reply-To: <20101027090921.GB8554@pengutronix.de>
References: <1288119235-7036-1-git-send-email-Dinh.Nguyen@freescale.com>
	<20101027082958.GA6797@angua.secretlab.ca>
	<20101027090921.GB8554@pengutronix.de>
Message-ID: <20101027102253.GA7822@angua.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 27, 2010 at 11:09:21AM +0200, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Wed, Oct 27, 2010 at 09:29:59AM +0100, Grant Likely wrote:
> > > ---
> > >  arch/arm/plat-mxc/include/mach/iomux-mx53.h |  301 +++++++++++++++++++
> > >  arch/arm/plat-mxc/include/mach/mx53.h       |  433 +++++++++++++++++++++++++++
> > 
> > Hi Dinh.
> > 
> > In general, these definitions should not be added until they are
> > actually needed by driver code.
> ack.
> 
> > Also, from my understanding, the mx53 is very similar to the mx51.
> > If I'm correct, then they should be sharing the same set of #defines.
> Note, I asked for a seperate header file.  See
> http://thread.gmane.org/gmane.linux.kernel/1051001/focus=1051352

For the record, I disagree with that approach.  The approach I would
take is for the imx53 code to use the imx51 defines by default, and to
only define imx53 variants where there are differences.  Otherwise the
code to support imx53 has to be completely divergent from imx51
because the defines are different symbols.

g.
