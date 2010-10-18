From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Oct 2010 23:13:53 +0100
Subject: [PATCH 2/3] arm: return both physical and virtual addresses
	from addruart
In-Reply-To: <1287439266.5588.64.camel@c-dwalke-linux.qualcomm.com>
References: <1283303270.566757.315468531956.2.gpush@pororo>
	<1287439266.5588.64.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <20101018221353.GE20376@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 18, 2010 at 03:01:06PM -0700, Daniel Walker wrote:
> On Wed, 2010-09-01 at 09:07 +0800, Jeremy Kerr wrote:
> 
> > ---
> >  arch/arm/kernel/debug.S                             |   22 +-
> >  arch/arm/mach-aaec2000/include/mach/debug-macro.S   |   10 
> >  arch/arm/mach-at91/include/mach/debug-macro.S       |    8 
> >  arch/arm/mach-clps711x/include/mach/debug-macro.S   |   12 -
> >  arch/arm/mach-cns3xxx/include/mach/debug-macro.S    |   10 
> >  arch/arm/mach-davinci/include/mach/debug-macro.S    |   46 ++--
> >  arch/arm/mach-dove/include/mach/debug-macro.S       |   11 -
> >  arch/arm/mach-ebsa110/include/mach/debug-macro.S    |    7 
> >  arch/arm/mach-ep93xx/include/mach/debug-macro.S     |   11 -
> >  arch/arm/mach-footbridge/include/mach/debug-macro.S |   22 --
> >  arch/arm/mach-gemini/include/mach/debug-macro.S     |    8 
> >  arch/arm/mach-h720x/include/mach/debug-macro.S      |   10 
> >  arch/arm/mach-integrator/include/mach/debug-macro.S |   10 
> >  arch/arm/mach-iop13xx/include/mach/debug-macro.S    |   16 -
> >  arch/arm/mach-iop32x/include/mach/debug-macro.S     |    7 
> >  arch/arm/mach-iop33x/include/mach/debug-macro.S     |   12 -
> >  arch/arm/mach-ixp2000/include/mach/debug-macro.S    |   14 -
> >  arch/arm/mach-ixp23xx/include/mach/debug-macro.S    |   11 -
> >  arch/arm/mach-ixp4xx/include/mach/debug-macro.S     |   16 -
> >  arch/arm/mach-kirkwood/include/mach/debug-macro.S   |   11 -
> >  arch/arm/mach-ks8695/include/mach/debug-macro.S     |    8 
> >  arch/arm/mach-l7200/include/mach/debug-macro.S      |   38 +++
> >  arch/arm/mach-lh7a40x/include/mach/debug-macro.S    |   10 
> >  arch/arm/mach-loki/include/mach/debug-macro.S       |   11 -
> >  arch/arm/mach-mmp/include/mach/debug-macro.S        |   11 -
> >  arch/arm/mach-msm/include/mach/debug-macro.S        |   10 
> 
> Firstly, you should try to break this kind of patch up if you can.

That's already been covered today with you.  You're not listening.
It can not be split up.  It is one logical change.  Splitting it up
will break the build for everything until the entire patch is merged.

> Secondly, you need to CC all the effected sub-architecture maintainers.
> It's not acceptable to assume that everyone effected will magically
> stumble onto this patch and know you modifying their sub-architecture ..

Read the friggin subject line.  linux-arm-kernel is where generic changes
get discussed all the time.  These changes will impact platform support.
Sometimes that's not going to be obvious that it affects your platform.
You need to be reading those changes.  Look at the subject line of each
mail and decide whether it's something that you need to look at.

In any case, it's not practical to copy a patch to 209 people - with
some 8K of CC or To line.

Why aren't you using this time which I've given you to resolve your
problem?
