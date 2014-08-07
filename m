From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 7 Aug 2014 13:53:03 +0800
Subject: [PATCH V2 4/4] ARM: dts: i.MX53: Add PMU DT entry
In-Reply-To: <53E22F35.4060503@parkeon.com>
References: <20140805144831.25462.18149.stgit@localhost>
 <20140805144840.25462.57101.stgit@localhost> <20140806105048.GF25953@arm.com>
 <53E22F35.4060503@parkeon.com>
Message-ID: <20140807055301.GD27051@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 06, 2014 at 03:35:49PM +0200, Martin Fuzzey wrote:
> On 06/08/14 12:50, Will Deacon wrote:
> >On Tue, Aug 05, 2014 at 03:48:40PM +0100, Martin Fuzzey wrote:
> >>Add device tree node for PMU on i.MX53
> >>
> >>Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
> >>---
> >>  arch/arm/boot/dts/imx53.dtsi |    5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >>diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> >>index 6456a00..ab3afe0 100644
> >>--- a/arch/arm/boot/dts/imx53.dtsi
> >>+++ b/arch/arm/boot/dts/imx53.dtsi
> >>@@ -101,6 +101,11 @@
> >>  		interrupt-parent = <&tzic>;
> >>  		ranges;
> >>+		pmu {
> >>+			compatible = "arm,cortex-a8-pmu";
> >>+			interrupts = <77>;
> >>+		};
> >You're missing the new property.
> 
> Actually this was deliberate.
> 
> Since the property should only be used if booting in secure mode
> this generic dtsi file can't know if it is ok or not.

As far as I know, most of the i.MX53 systems boot Linux kernel in secure
mode.  In that case, we should probably have the new property by
default?

Shawn

> I presume a (probably out of tree) board / application dts file will
> add the property.
> 
> Maybe I should put a comment here about that though?
> 
> Martin
