From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 29 Apr 2011 15:43:27 -0400 (EDT)
Subject: [PATCH] ARM: Include Makefile.boot only when it exists
In-Reply-To: <20110429133340.GN5126@n2100.arm.linux.org.uk>
References: <1303103976-4922-1-git-send-email-eric.y.miao@gmail.com>
	<20110420083258.GB1517@S2100-06.ap.freescale.net>
	<BANLkTiknesdF7cMZ=RGJAh75aW_wRpyj-w@mail.gmail.com>
	<20110428152735.GU17290@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104281925500.24613@xanadu.home>
	<20110429075346.GU17290@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104290814380.24613@xanadu.home>
	<20110429133340.GN5126@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1104291514390.24613@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Apr 2011, Russell King - ARM Linux wrote:

> On Fri, Apr 29, 2011 at 08:32:59AM -0400, Nicolas Pitre wrote:
> > What do I not understand?  Let me repeat myself again:
> > 
> > | DT files should be a representation of the hardware which is meant to 
> > | be stable. [...] Hence the DT files for existing hardware shouldn't 
> > | have to change even if the kernel side implementation does.
> > 
> > So there shouldn't be constant changes to those files as they are 
> > supposed to be hardware description only.
> 
> You really haven't seen what goes on in the OMAP community then.  If
> you think its possible to come up with a hardware description of the
> OMAP clock tree which is right first time, you're in cloud cuckoo land.

(sigh) I wish you were wrong on that, but admittedly I'm highly skeptical 
myself.

> Even the OMAP4 clock data which is supposedly generated from TIs
> internal hardware database changes on a fairly regular basis.  You'll
> find that the per-clk flags get changed, the operations get changed,
> etc.
> 
> It doesn't _matter_ how it is represented, it will continue to be patched
> whether it's structures in a .c file (as it currently is) or whether it's
> a device tree description for each clock.

If that is the case, the associated drivers have to change as well to be 
in sync with the new flags, etc.  And to me it is way better to have 
both the data and the drivers maintained in a single place compared to 
the unavoidable bugs that will crop up due to version skews.

Unfortunately, and IMHO, this whole drama has put one spotlight on the 
OMAP clock tables, but that alone is not such a problem in the big 
picture compared to the issue of code duplication which is actually a 
real maintenance problem.  And now we of course have to throw out the 
baby with the bath water.

Whatever... Rest assured that you are not the one to blame here.


Nicolas
