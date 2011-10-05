From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 04 Oct 2011 20:57:49 -0400 (EDT)
Subject: Please help with the OMAP static mapping mess
In-Reply-To: <20111005004208.GW6324@atomide.com>
References: <alpine.LFD.2.02.1110031312480.9106@xanadu.home>
	<20111003205658.GJ6324@atomide.com>
	<alpine.LFD.2.02.1110031744100.9106@xanadu.home>
	<20111003224411.GA19897@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1110041528050.9106@xanadu.home>
	<20111004225424.GA32102@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1110041900590.9106@xanadu.home>
	<20111005004208.GW6324@atomide.com>
Message-ID: <alpine.LFD.2.02.1110042048320.9106@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Oct 2011, Tony Lindgren wrote:

> In any case, I suggest we add the following __arm_ioremap_exec patch
> and then sort out issues with it as they show up.
> 
> This allows further work on the common SRAM genalloc patches and generic
> map_io patches.
> 
> Nico, I already have a series converting omap2+ to use the the patch
> below, and it seems to be working just fine for SRAM. I'll post that
> series separately shortly. Maybe take a look and see if that allows
> you to do the generic map_io changes?

Yes, that looks fine.  Maybe you could avoid exporting the symbol until 
it is actually needed though.

The other thing I need is for the code using ioremap() such as in 
omap2_set_globals_control() to be called only after the corresponding 
static mappings are already installed.  Then everything should go 
smoothly.


Nicolas
