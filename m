From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 18 Oct 2010 15:44:14 -0700
Subject: [PATCH 2/3] arm: return both physical and virtual addresses
	from addruart
In-Reply-To: <20101018221353.GE20376@n2100.arm.linux.org.uk>
References: <1283303270.566757.315468531956.2.gpush@pororo>
	<1287439266.5588.64.camel@c-dwalke-linux.qualcomm.com>
	<20101018221353.GE20376@n2100.arm.linux.org.uk>
Message-ID: <1287441854.5588.100.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-10-18 at 23:13 +0100, Russell King - ARM Linux wrote:
> On Mon, Oct 18, 2010 at 03:01:06PM -0700, Daniel Walker wrote:
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
> That's already been covered today with you.  You're not listening.
> It can not be split up.  It is one logical change.  Splitting it up
> will break the build for everything until the entire patch is merged.

I said "if you can" I didn't say "break this patch up." I also said "in
the future" so I'm not talking about this patch anymore..

> > Secondly, you need to CC all the effected sub-architecture maintainers.
> > It's not acceptable to assume that everyone effected will magically
> > stumble onto this patch and know you modifying their sub-architecture ..
> 
> Read the friggin subject line.  linux-arm-kernel is where generic changes
> get discussed all the time.  These changes will impact platform support.
> Sometimes that's not going to be obvious that it affects your platform.
> You need to be reading those changes.  Look at the subject line of each
> mail and decide whether it's something that you need to look at.

That's not addressing the problem .. I don't actually care about this
change, all I care about is that it's changing files in my tree and I
need to keep aware of it so it doesn't cause problems down the line.
It's not about patch content.

I can't look at the subject line and know that this patches is modifying
files in my tree.

> In any case, it's not practical to copy a patch to 209 people - with
> some 8K of CC or To line.

Then don't CC 8k people, no one is saying you have to CC all 209. You
just have to CC the maintainers.

> Why aren't you using this time which I've given you to resolve your
> problem?

I will send you a pull request by your deadline, even if I don't I
understand the consequences (which you have alerted me too).

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
