From: horms@verge.net.au (Simon Horman)
Date: Wed, 20 Dec 2017 11:06:17 +0100
Subject: [PATCH v2 1/2] ARM: dts: r8a7743: sort root sub-nodes
 alphabetically
In-Reply-To: <20171220100131.u5bjyce3mp2rj7cx@verge.net.au>
References: <20171218214043.10796-1-horms+renesas@verge.net.au>
 <20171218214043.10796-2-horms+renesas@verge.net.au>
 <CAMuHMdVNCyW=QU08eg=1j8Xyq1wBhsY6KxmpjCLi8X7mZD8YCw@mail.gmail.com>
 <20171220100131.u5bjyce3mp2rj7cx@verge.net.au>
Message-ID: <20171220100616.pgtfnjis4wlkw2ud@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 20, 2017 at 11:01:32AM +0100, Simon Horman wrote:
> On Tue, Dec 19, 2017 at 09:43:06AM +0100, Geert Uytterhoeven wrote:
> > Hi Simon,
> > 
> > On Mon, Dec 18, 2017 at 10:40 PM, Simon Horman
> > <horms+renesas@verge.net.au> wrote:
> > > Sort root sub-nodes alphabetically for allow for easier maintenance
> > 
> > to allow for
> > 
> > > of this file.
> > >
> > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > 
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > 
> > > --- a/arch/arm/boot/dts/r8a7743.dtsi
> > > +++ b/arch/arm/boot/dts/r8a7743.dtsi
> > 
> > >         cpus {
> > >                 #address-cells = <1>;
> > >                 #size-cells = <0>;
> > > @@ -79,6 +102,37 @@
> > >                 };
> > >         };
> > >
> > > +       /* External CAN clock */
> > > +       can_clk: can {
> > 
> > Doesn't look alphabetically to me...
> 
> Thanks, I have applied the following:

Yikes, that left a duplicate extal node.
I now have this:

From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH] ARM: dts: r8a7743: sort root sub-nodes alphabetically

Sort root sub-nodes alphabetically to allow for easier maintenance
of this file.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7743.dtsi | 108 ++++++++++++++++++++---------------------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index f24f36d50e40..ecbd39e5f630 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -37,6 +37,37 @@
 		vin2 = &vin2;
 	};
 
+	/*
+	 * The external audio clocks are configured as 0 Hz fixed frequency
+	 * clocks by default.
+	 * Boards that provide audio clocks should override them.
+	 */
+	audio_clk_a: audio_clk_a {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	audio_clk_b: audio_clk_b {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	audio_clk_c: audio_clk_c {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	/* External CAN clock */
+	can_clk: can {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board. */
+		clock-frequency = <0>;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -79,6 +110,29 @@
 		};
 	};
 
+	/* External root clock */
+	extal_clk: extal {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board. */
+		clock-frequency = <0>;
+	};
+
+	/* External PCIe clock - can be overridden by the board */
+	pcie_bus_clk: pcie_bus {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	/* External SCIF clock */
+	scif_clk: scif {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board. */
+		clock-frequency = <0>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&gic>;
@@ -1621,64 +1675,10 @@
 		};
 	};
 
-	/* External root clock */
-	extal_clk: extal {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		/* This value must be overridden by the board. */
-		clock-frequency = <0>;
-	};
-
-	/*
-	 * The external audio clocks are configured as 0 Hz fixed frequency
-	 * clocks by default.
-	 * Boards that provide audio clocks should override them.
-	 */
-	audio_clk_a: audio_clk_a {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <0>;
-	};
-
-	audio_clk_b: audio_clk_b {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <0>;
-	};
-
-	audio_clk_c: audio_clk_c {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <0>;
-	};
-
 	/* External USB clock - can be overridden by the board */
 	usb_extal_clk: usb_extal {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <48000000>;
 	};
-
-	/* External CAN clock */
-	can_clk: can {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		/* This value must be overridden by the board. */
-		clock-frequency = <0>;
-	};
-
-	/* External PCIe clock - can be overridden by the board */
-	pcie_bus_clk: pcie_bus {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <0>;
-	};
-
-	/* External SCIF clock */
-	scif_clk: scif {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		/* This value must be overridden by the board. */
-		clock-frequency = <0>;
-	};
 };
-- 
2.11.0
