From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 9 Feb 2018 10:58:18 +0800
Subject: [PATCH v2] ARM: dts: imx6ull: add Toradex Colibri iMX6ULL support
In-Reply-To: <e441573ee4f3b66fc39ffce2a4fb7a04@agner.ch>
References: <20180206164903.24913-1-stefan@agner.ch>
 <20180208074730.GF31910@dragon>
 <e441573ee4f3b66fc39ffce2a4fb7a04@agner.ch>
Message-ID: <20180209025817.GJ31910@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 08, 2018 at 10:25:47AM +0100, stefan at agner.ch wrote:
> On 08.02.2018 08:47, Shawn Guo wrote:
> > On Tue, Feb 06, 2018 at 05:49:03PM +0100, Stefan Agner wrote:
> >> Add support for the Computer on Module Colibri iMX6ULL and its
> >> Bluetooth/Wifi variant along with the development/evaluation carrier
> >> board device trees. Follow the usual hierarchic include model,
> >> maintaining shared configuration in imx6ull-colibri.dtsi and
> >> imx6ull-colibri-eval-v3.dtsi respectively.
> >>
> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
> >> ---
> >> This depends on the following patchsets work:
> >> - https://lkml.org/lkml/2018/1/6/129 (applied)
> >> - https://lkml.org/lkml/2018/1/10/998 (applied)
> >> - https://www.spinics.net/lists/arm-kernel/msg632671.html (pending, required)
> >> - https://lkml.org/lkml/2018/1/18/850 (only for highest CPU frequency)
> > 
> > So the only dependency is the cpufreq change now.  So we have two
> > options:
> > 
> > 1. Hold the patch until the cpufreq change appear on my tree.  That
> >    will require us wait for another release cycle.
> > 
> > 2. Drop the highest CPU frequency, so that we can apply the patch right
> >    away, and add that setpoint after dependant cpufreq change lands
> >    mainline.
> 
> The way cpufreq currently works is that for everything higher than
> 396MHz it just will set the CPU parent to pll2_bus_clk which can go up
> to 528MHz. Also voltage should be within operation range even for
> 528MHz.
> 
> So I think we can safely merge the current device tree.

Okay, thanks for the info.  Patch applied.

Shawn
