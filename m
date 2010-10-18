From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 18 Oct 2010 15:52:12 -0700
Subject: [PATCH 2/3] arm: return both physical and virtual addresses
	from addruart
In-Reply-To: <alpine.LFD.2.00.1010181817410.2764@xanadu.home>
References: <1283303270.566757.315468531956.2.gpush@pororo>
	<1287439266.5588.64.camel@c-dwalke-linux.qualcomm.com>
	<alpine.LFD.2.00.1010181817410.2764@xanadu.home>
Message-ID: <1287442332.5588.108.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-10-18 at 18:30 -0400, Nicolas Pitre wrote:
> On Mon, 18 Oct 2010, Daniel Walker wrote:
> 
> > On Wed, 2010-09-01 at 09:07 +0800, Jeremy Kerr wrote:
> > 
> > > ---
> > >  arch/arm/kernel/debug.S                             |   22 +-
> > >  arch/arm/mach-aaec2000/include/mach/debug-macro.S   |   10 
> > >  arch/arm/mach-at91/include/mach/debug-macro.S       |    8 
> > >  arch/arm/mach-clps711x/include/mach/debug-macro.S   |   12 -
> > >  arch/arm/mach-cns3xxx/include/mach/debug-macro.S    |   10 
> > >  arch/arm/mach-davinci/include/mach/debug-macro.S    |   46 ++--
> > >  arch/arm/mach-dove/include/mach/debug-macro.S       |   11 -
> > >  arch/arm/mach-ebsa110/include/mach/debug-macro.S    |    7 
> > >  arch/arm/mach-ep93xx/include/mach/debug-macro.S     |   11 -
> > >  arch/arm/mach-footbridge/include/mach/debug-macro.S |   22 --
> > >  arch/arm/mach-gemini/include/mach/debug-macro.S     |    8 
> > >  arch/arm/mach-h720x/include/mach/debug-macro.S      |   10 
> > >  arch/arm/mach-integrator/include/mach/debug-macro.S |   10 
> > >  arch/arm/mach-iop13xx/include/mach/debug-macro.S    |   16 -
> > >  arch/arm/mach-iop32x/include/mach/debug-macro.S     |    7 
> > >  arch/arm/mach-iop33x/include/mach/debug-macro.S     |   12 -
> > >  arch/arm/mach-ixp2000/include/mach/debug-macro.S    |   14 -
> > >  arch/arm/mach-ixp23xx/include/mach/debug-macro.S    |   11 -
> > >  arch/arm/mach-ixp4xx/include/mach/debug-macro.S     |   16 -
> > >  arch/arm/mach-kirkwood/include/mach/debug-macro.S   |   11 -
> > >  arch/arm/mach-ks8695/include/mach/debug-macro.S     |    8 
> > >  arch/arm/mach-l7200/include/mach/debug-macro.S      |   38 +++
> > >  arch/arm/mach-lh7a40x/include/mach/debug-macro.S    |   10 
> > >  arch/arm/mach-loki/include/mach/debug-macro.S       |   11 -
> > >  arch/arm/mach-mmp/include/mach/debug-macro.S        |   11 -
> > >  arch/arm/mach-msm/include/mach/debug-macro.S        |   10 
> > 
> > Firstly, you should try to break this kind of patch up if you can.
> 
> It was split as much as possible already.
> 
> > Secondly, you need to CC all the effected sub-architecture maintainers.
> 
> There are 367 different machines affected.  Please get real.  Sorry but 
> you are not more special than the others.  The MSM is only one of the 
> many subarchitectures that the core ARM code serves.

We're not talking about machines, we're talking about maintainers. There
are only 70 mach- directories and as far as I can tell your only
changing a sub-set of those.

> > It's not acceptable to assume that everyone effected will magically
> > stumble onto this patch and know you modifying their sub-architecture ..
> 
> This is precisely why RMK asked for those patches to be merged at the 
> end of his merge cycle.  Bypassing RMK for your own merge requests is 
> only going to cause you similar trouble in the future.

I don't want to get into this discussion ..

> > Please do those things with future patches.
> 
> I'm sorry Daniel, but you are not in a position to lecture people with 
> such language in this case.  You were told repeatedly so far about what 
> you should do right now.  Everyone involved did their best except you at 
> this point.

I'm doing what I need to do.

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
