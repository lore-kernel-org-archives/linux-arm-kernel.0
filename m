From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 14 Jul 2014 22:04:05 +0800
Subject: [PATCH v2 0/4] ARM: vf610: add FlexCAN support
In-Reply-To: <53C39052.7040400@pengutronix.de>
References: <cover.1405322992.git.stefan@agner.ch>
 <53C39052.7040400@pengutronix.de>
Message-ID: <20140714140404.GJ2197@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 14, 2014 at 10:09:54AM +0200, Marc Kleine-Budde wrote:
> On 07/14/2014 09:48 AM, Stefan Agner wrote:
> > This series adds support for Vybrid (aka vf610) to the FlexCAN
> > controller and extends the device tree accordingly.
> > 
> > Changes in v2:
> > - Split out patch (seperate dt, clocks and driver changes)
> > - Use spaces for hardware feature flags table
> > - Remove drive-by change of esdhc register length
> > - Added related fix which enables clock in berr_counter
> > 
> > Stefan Agner (4):
> >   ARM: dts: vf610: add FlexCAN node
> >   ARM: imx: clk-vf610: fix FlexCAN clock gating
> >   can: flexcan: switch on clocks before accessing ecr register
> >   can: flexcan: add vf610 support for FlexCAN
> > 
> >  arch/arm/boot/dts/vf610.dtsi  | 23 +++++++++++
> >  arch/arm/mach-imx/clk-vf610.c |  6 ++-
> >  drivers/net/can/flexcan.c     | 89 ++++++++++++++++++++++++++++++++++++++-----
> >  3 files changed, 106 insertions(+), 12 deletions(-)
> 
> Shawn, what's the best way to upstream this? With your Ack, I can take
> everything via linux-can-next.

Since this is a new support and there is nothing to maintain git bisect,
I think the best way is to have the first two patches to go via my tree.

Shawn
