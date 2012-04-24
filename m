From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Tue, 24 Apr 2012 11:40:11 +0800
Subject: [PATCH 1/2] pinctrl: add pinctrl-mxs support
In-Reply-To: <20120423144623.GU26306@S2101-09.ap.freescale.net>
References: <1334823125-24159-1-git-send-email-shawn.guo@linaro.org>
 <20120421164713.GA3408@das-ThinkPad-X61>
 <20120422163255.GD26306@S2101-09.ap.freescale.net>
 <20120423074702.GD24843@shlinux2.ap.freescale.net>
 <20120423144623.GU26306@S2101-09.ap.freescale.net>
Message-ID: <20120424034010.GA32166@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2012 at 10:46:26PM +0800, Shawn Guo wrote:
> On Mon, Apr 23, 2012 at 03:47:03PM +0800, Dong Aisheng wrote:
> > On Mon, Apr 23, 2012 at 12:32:58AM +0800, Shawn Guo wrote:
> > > On Sun, Apr 22, 2012 at 12:47:13AM +0800, Dong Aisheng wrote:
> > > > On Thu, Apr 19, 2012 at 04:12:05PM +0800, Shawn Guo wrote:
> > > > > Add pinctrl support for Freescale MXS SoCs, i.MX23 and i.MX28.
> > > > > The driver supports device tree probe only.
> > > > > 
> > > > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > > > ---
> > > > First, it seems i.MX23 and i.MX28 have the same situation as
> > > > other IMX families like i.MX6Q that they're all pin based
> > > > SoCs. Thus i think the correct thing to do now may be to
> > > > enhance pinctrl-imx core driver to support them all rather
> > > > than write a much similar one only for i.MX23 and i.MX28,
> > > > right?
> > > > 
> > > I would think there will be SoCs from other vendors sharing the same
> > > situation.  My view on this is to have them in and then look for the
> > > common pattern among these drivers and come up with some generic
> > > helper functions.
> > > 
> > We may get align with all FSL families first.
> > At least the binding part could be the same.
> > The most difference between MXS and IMX is different register layout.
> > For example, pinconf_set/get may be different.
> > One rough idea in my mind is that one callback in pinctrl-imx may
> > handle it.
> > 
> You haven't convinced me that the imx binding you came up with your
> v2 series plays well for mxs.
> 
Then please feel free to comment on the pinctrl-imx binding if you've
different option for mxs.
But i did not receive you comment...

I think we'd better have a face to face discussion when you come to office.
At least one unified binding for all FSL SoCs is our goal, isn't it?

BTW one idea in my mind is that we indeed may want pinctrl subsystem support
config a group of pins based on pin config which i rasied in my v2 patch.
I'm going to send a patch and discuss with Linus and Stephen more.
If that works, we really do not have to do as you did for mxs
for all FSL SoCs.

Regards
Dong Aisheng
