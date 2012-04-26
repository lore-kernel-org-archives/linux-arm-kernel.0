From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Thu, 26 Apr 2012 19:22:54 +0800
Subject: [PATCH 1/2] pinctrl: add pinctrl-mxs support
In-Reply-To: <CACRpkdZp__NJK0DcWwjLaW88_dpeAMS04UZxfaamXUHUDqTB8g@mail.gmail.com>
References: <20120421164713.GA3408@das-ThinkPad-X61>
 <20120422163255.GD26306@S2101-09.ap.freescale.net>
 <20120423074702.GD24843@shlinux2.ap.freescale.net>
 <20120423144623.GU26306@S2101-09.ap.freescale.net>
 <20120424034010.GA32166@shlinux2.ap.freescale.net>
 <20120424040520.GC26306@S2101-09.ap.freescale.net>
 <CACRpkdZ0USvyvT-YB3=VM5rb3VQ9-kVRwarZL82jMCz4J_wgUg@mail.gmail.com>
 <20120424132648.GF26306@S2101-09.ap.freescale.net>
 <20120424142557.GC24122@shlinux2.ap.freescale.net>
 <CACRpkdZp__NJK0DcWwjLaW88_dpeAMS04UZxfaamXUHUDqTB8g@mail.gmail.com>
Message-ID: <20120426112253.GB26070@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 04:41:30PM +0800, Linus Walleij wrote:
> On Tue, Apr 24, 2012 at 4:25 PM, Dong Aisheng
> <aisheng.dong@freescale.com> wrote:
> > On Tue, Apr 24, 2012 at 09:26:51PM +0800, Shawn Guo wrote:
> >> On Tue, Apr 24, 2012 at 03:07:35PM +0200, Linus Walleij wrote:
> >> > Hm, that's pretty interesting - but are imx and mxs even going to use the
> >> > same driver then? Maybe I'm not following - are they similar
> >> > in all other aspects than for this pin config stuff?
> >> >
> >> The mach-mxs (i.MX23 and i.MX28) is a totally different sub-architecture
> >> from mach-imx. ?Freescale acquired it from SigmaTel a few years back.
> >> These two sub-architectures have completely different pin controllers.
> >> So, no, they are not going to use the same pinctrl driver but two
> >> different ones, pinctrl-mxs and pinctrl-imx.
> >>
> >> The only common aspect is both two controllers only supports pin basis
> >> configuration (no hardware pingroup). ?I think many other
> >> sub-architectures including omap are same on this aspect.
> >>
> > The key point is not the hw difference, it is if we can find common part
> > on a higher abstract layer, that's what a subsystem or a good
> > designed common driver do, right?
> 
> Yep if there are similarities between i.MX and MXS I guess these
> similarities will be between these and Tegra/OMAP etc also.
> 
> And then it goes into the pinctrl subsystem of course.
> 
Yes, i guess mostly may be the binding part for pin based SoC and
common high level pin_or_group get/set/enable(assume many of us
are referencing your pinctrl-u300 driver) and etc...

But i guess it may be a little early to cover different vendors right now
since different vendor SoC pinctrl driver owner may want to do on
their convention way currently and different SoC may have some hw specific
binding which is suitable for their own.
For example, there are different binding between FSL and Tegra.

My original plan is to get FSL aligned first and get patch in first.
If other people really have the interest, they can see the code and enhance
it or re-design a new more generic one to cover more SoCs if they like.

Shawn and i had a discussion on int yesterday, we found some
alignment but may still not enough to decide to do mxs and imx align right now
since we're still missing some common bits like dtc macro and
pinctrl still does not support per pin config in a group
(i'm trying to do it now).

So i may agree that mxs and imx can go separately first if Shawn
would like it.

> > My key point is to do common things like dt binding in pinctrl-imx and
> > handle hw difference in each SoC pinctrl driver.
> 
> I think we tried to create common device tree bindings and
> partly failed to reach common ground so we now have a compromise
> where each driver needs to plug in its own parser in the
> dt_node_to_map() and dt_free_map() hooks...
> 
> (OMG these two are not kerneldoc:ed, I need to poke Stephen.)
> 
> Yours,
> Linus Walleij
> 

Regards
Dong Aisheng
