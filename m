From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 21 Mar 2014 23:08:22 +0100
Subject: [PATCH v2 4/5] ARM: berlin/dt: add cpupll and syspll support to
 BG2CD
In-Reply-To: <532CB09E.5000408@gmail.com>
References: <1395432521-11055-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1395432521-11055-5-git-send-email-alexandre.belloni@free-electrons.com>
 <532CB09E.5000408@gmail.com>
Message-ID: <20140321220821.GI6443@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/03/2014 at 22:35:26 +0100, Sebastian Hesselbarth wrote :
> On 03/21/2014 09:08 PM, Alexandre Belloni wrote:
> >The Berlin BG2CD has two supported PLLs: CPU PLL and System PLL, add those to
> >the SoC device tree.
> >
> >This also moves the remaining clocks from the clocks container node to the root.
> >
> >Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> >---
> >  arch/arm/boot/dts/berlin2cd.dtsi | 48 ++++++++++++++++++++++++++--------------
> >  1 file changed, 31 insertions(+), 17 deletions(-)
> >
> >diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
> >index 094968c27533..bd4e9dd4867e 100644
> >--- a/arch/arm/boot/dts/berlin2cd.dtsi
> >+++ b/arch/arm/boot/dts/berlin2cd.dtsi
> >@@ -30,24 +30,24 @@
> [...]
> >@@ -76,7 +76,21 @@
> >  			compatible = "arm,cortex-a9-twd-timer";
> >  			reg = <0xad0600 0x20>;
> >  			interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
> >-			clocks = <&sysclk>;
> >+			clocks = <&twdclk>;
> >+		};
> >+
> >+		syspll: syspll at ea0014 {
> >+			compatible = "marvell,berlin2-pll";
> >+			clocks = <&smclk>;
> >+			#clock-cells = <0>;
> >+			reg = <0xf7ea0014 8>;
> 
> nit: I prefer hex numbers all over for reg properties. berlin2q already
> has them, and I'll fixup this and the one below myself.
> 

Indeed, I did fix that for bg2q and documentation and forgot bg2 and
bg2cd.

> >+		};
> >+
> >+		cpupll: cpupll at ea003c {
> >+			compatible = "marvell,berlin2-pll";
> >+			clocks = <&smclk>;
> >+			#clock-cells = <0>;
> >+			reg = <0xf7ea003c 8>;
> 
> ditto.
> 
> Sebastian
> 
> >  		};
> >
> >  		apb at e80000 {
> >
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
