From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 04 May 2011 09:38:50 -0400 (EDT)
Subject: [PATCHv3] ARM:boot:device tree: Allow the device tree binary to be
	appended to zImage
In-Reply-To: <20110504072317.GU2092@atomide.com>
References: <20110420073445.GB31127@S2100-06.ap.freescale.net>
	<20110421080238.GE13688@atomide.com>
	<20110421124618.GA15060@atomide.com>
	<20110427142306.GI3755@atomide.com>
	<alpine.LFD.2.00.1104271036520.24613@xanadu.home>
	<20110427144335.GK3755@atomide.com> <20110429102623.GX3755@atomide.com>
	<alpine.LFD.2.00.1104290909310.24613@xanadu.home>
	<20110429135334.GR5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104291509540.24613@xanadu.home>
	<20110504072317.GU2092@atomide.com>
Message-ID: <alpine.LFD.2.00.1105040936040.24613@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 4 May 2011, Tony Lindgren wrote:

> * Nicolas Pitre <nico@fluxnic.net> [110429 12:11]:
> > I don't think the DT data is that huge, but that's a point in favor of 
> > doing it in the zImage code.  We'll just need to feed the total size of 
> > the uncompressed kernel .bss section to zImage when compiling it.
> 
> One more thing to consider though.. I don't think we want to copy the
> DT data twice. It's not big right now, but could get large if we pass
> all the clocks in it.
> 
> So this should be probably fixed in the original patch.. John got
> any thoughts on that?

No.  The original patch is good (and complex) enough as it is now.  It 
already required 3 rounds of reviews before it was right. This should be 
fixed in a subsequent patch.


Nicolas
