From: horms@verge.net.au (Simon Horman)
Date: Wed, 20 Dec 2017 10:35:38 +0100
Subject: [PATCH 1/2] ARM: dts: r8a7792: sort root sub-nodes alphabetically
In-Reply-To: <14c60234-3755-3b06-64fc-e3943d8b5293@cogentembedded.com>
References: <20171218213233.3373-1-horms+renesas@verge.net.au>
 <20171218213233.3373-2-horms+renesas@verge.net.au>
 <14c60234-3755-3b06-64fc-e3943d8b5293@cogentembedded.com>
Message-ID: <20171220093538.e5t3ujc5vjoerv5d@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 12:27:48PM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 12/19/2017 12:32 AM, Simon Horman wrote:
> 
> > Sort root sub-nodes alphabetically for allow for easier maintenance
> 
>    s/for/to/?
> 
> > of this file.
> > 
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >   arch/arm/boot/dts/r8a7792.dtsi | 48 +++++++++++++++++++++---------------------
> >   1 file changed, 24 insertions(+), 24 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/r8a7792.dtsi
> > index ac05fdb91798..d31258958c36 100644
> > --- a/arch/arm/boot/dts/r8a7792.dtsi
> > +++ b/arch/arm/boot/dts/r8a7792.dtsi
> > @@ -36,6 +36,22 @@
> >   		vin5 = &vin5;
> >   	};
> > +	/* External root clock */
> > +	extal_clk: extal {
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		/* This value must be overridden by the board. */
> > +		clock-frequency = <0>;
> > +	};
> > +
> > +	/* External CAN clock */
> > +	can_clk: can {
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		/* This value must be overridden by the board. */
> > +		clock-frequency = <0>;
> > +	};
> > +
> 
>    C predates E in my alphabet. :-)

Thanks, I have applied the following:

From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH] ARM: dts: r8a7792: sort root sub-nodes alphabetically

Sort root sub-nodes alphabetically to allow for easier maintenance
of this file.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7792.dtsi | 48 +++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/r8a7792.dtsi
index 7b394273031e..b0013e5fcf47 100644
--- a/arch/arm/boot/dts/r8a7792.dtsi
+++ b/arch/arm/boot/dts/r8a7792.dtsi
@@ -36,6 +36,14 @@
 		vin5 = &vin5;
 	};
 
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
@@ -69,6 +77,22 @@
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
@@ -832,28 +856,4 @@
 			#power-domain-cells = <0>;
 		};
 	};
-
-	/* External root clock */
-	extal_clk: extal {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		/* This value must be overridden by the board. */
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
-
-	/* External CAN clock */
-	can_clk: can {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		/* This value must be overridden by the board. */
-		clock-frequency = <0>;
-	};
 };
-- 
2.11.0
