From: horms@verge.net.au (Simon Horman)
Date: Thu, 28 Nov 2013 17:05:41 +0900
Subject: [PATCH v2] ARM: shmobile: Fix r8a7790 GPIO resources in DTS
In-Reply-To: <20131125025033.GD2786@verge.net.au>
References: <20131121051929.16956.72693.sendpatchset@w520>
 <2488980.PvOPQv8Pxa@avalon> <20131125024008.GA813@verge.net.au>
 <20131125025033.GD2786@verge.net.au>
Message-ID: <20131128080540.GR24146@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 11:50:33AM +0900, Simon Horman wrote:
> On Mon, Nov 25, 2013 at 11:40:08AM +0900, Simon Horman wrote:
> > On Thu, Nov 21, 2013 at 09:29:49AM +0100, Laurent Pinchart wrote:
> > > Hi Magnus,
> > > 
> > > Thank you for the patch.
> > > 
> > > On Thursday 21 November 2013 14:19:29 Magnus Damm wrote:
> > > > From: Magnus Damm <damm@opensource.se>
> > > > 
> > > > The r8a7790 GPIO resources are currently incorrect. Fix that
> > > > by making them match the English r8a7790 v0.6 data sheet.
> > > > 
> > > > Tested with GPIO LED using Lager DT reference.
> > > > 
> > > > Signed-off-by: Magnus Damm <damm@opensource.se>
> > > 
> > > Just before I go and hide for such an obvious mistake,
> > > 
> > > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > 
> > > :-)
> > 
> > Hi, I would like to queue this up as a fix for v3.12 with the following
> > amended changelog.
> 
> s/12/13/
> 
> > 
> > I would also like to take this opportunity state that my preferred
> > subject format is: ARM: shmobile: soc or board: description
> > 
> > Could you cook up something similar for the r8a7791 variant of this patch?
> > 
> > 
> > [PATCH v2] ARM: shmobile: r8a7790: Fix GPIO resources in DTS
> > 
> > From: Magnus Damm <damm@opensource.se>
> > 
> > The r8a7790 GPIO resources are currently incorrect. Fix that
> > by making them match the English r8a7790 v0.6 data sheet.
> > 
> > Tested with GPIO LED using Lager DT reference.
> > 
> > This problem has been present since GPIOs were added to the r8a7790 SoC by
> > f98e10c88aa95bf7 ("ARM: shmobile: r8a7790: Add GPIO controller devices to
> > device tree") in v3.12-rc1.
> > 
> > Signed-off-by: Magnus Damm <damm@opensource.se>
> > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

I have queued-up the following. The code changes are identical to v2.
I have updated the changelog to the text above.


From: Magnus Damm <damm@opensource.se>

[PATCH v3] ARM: shmobile: r8a7790: Fix GPIO resources in DTS

The r8a7790 GPIO resources are currently incorrect. Fix that
by making them match the English r8a7790 v0.6 data sheet.

Tested with GPIO LED using Lager DT reference.

This problem has been present since GPIOs were added to the r8a7790 SoC by
f98e10c88aa95bf7 ("ARM: shmobile: r8a7790: Add GPIO controller devices to
device tree") in v3.12-rc1.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 0e4d5b5..68b7b87 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -90,9 +90,9 @@
 		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
-	gpio0: gpio at ffc40000 {
+	gpio0: gpio at e6050000 {
 		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
-		reg = <0 0xffc40000 0 0x2c>;
+		reg = <0 0xe6050000 0 0x50>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 4 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -102,9 +102,9 @@
 		interrupt-controller;
 	};
 
-	gpio1: gpio at ffc41000 {
+	gpio1: gpio at e6051000 {
 		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
-		reg = <0 0xffc41000 0 0x2c>;
+		reg = <0 0xe6051000 0 0x50>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 5 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -114,9 +114,9 @@
 		interrupt-controller;
 	};
 
-	gpio2: gpio at ffc42000 {
+	gpio2: gpio at e6052000 {
 		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
-		reg = <0 0xffc42000 0 0x2c>;
+		reg = <0 0xe6052000 0 0x50>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 6 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -126,9 +126,9 @@
 		interrupt-controller;
 	};
 
-	gpio3: gpio at ffc43000 {
+	gpio3: gpio at e6053000 {
 		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
-		reg = <0 0xffc43000 0 0x2c>;
+		reg = <0 0xe6053000 0 0x50>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 7 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -138,9 +138,9 @@
 		interrupt-controller;
 	};
 
-	gpio4: gpio at ffc44000 {
+	gpio4: gpio at e6054000 {
 		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
-		reg = <0 0xffc44000 0 0x2c>;
+		reg = <0 0xe6054000 0 0x50>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -150,9 +150,9 @@
 		interrupt-controller;
 	};
 
-	gpio5: gpio at ffc45000 {
+	gpio5: gpio at e6055000 {
 		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
-		reg = <0 0xffc45000 0 0x2c>;
+		reg = <0 0xe6055000 0 0x50>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 9 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
-- 
1.8.4
