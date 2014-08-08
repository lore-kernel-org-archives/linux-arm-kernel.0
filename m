From: tom@sharkbay.at (Thomas Scheiblauer)
Date: Fri, 08 Aug 2014 18:33:04 +0200
Subject: [PATCH 1/1] undo workaround for i.mx6 silicon errata ERR006687
 which resulted in an unstable ethernet connection (lost interrupts?)
In-Reply-To: <CAOMZO5C=sTL-ksaHX9uL=zyGR0d5hR8Rd5JAiQMTrr_0wiNdxQ@mail.gmail.com>
References: <1407503758.19455.1.camel@sharkbay.at>
 <20140808132754.GC30282@n2100.arm.linux.org.uk>
 <1407507023.19455.3.camel@sharkbay.at>
 <20140808143008.GD30282@n2100.arm.linux.org.uk>
 <1407509932.19455.7.camel@sharkbay.at>
 <CAOMZO5C=sTL-ksaHX9uL=zyGR0d5hR8Rd5JAiQMTrr_0wiNdxQ@mail.gmail.com>
Message-ID: <1407515584.19455.9.camel@sharkbay.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > 
> > On Fre, 2014-08-08 at 12:46 -0300, Fabio Estevam wrote:
> > Hi Thomas,
> > 
> > On Fri, Aug 8, 2014 at 11:58 AM, Thomas Scheiblauer <tom@sharkbay.at> wrote:
> > 
> > >> So, what I'm asking is to try without this workaround in case there is
> > >> some interaction there, thus testing the same interrupt configuration
> > >> that I've had here for the last 10 months without the kind of issues
> > >> you're reporting.  Sometimes, workarounds for one problem end up causing
> > >> other problem elsewhere.
> > >>
> > >
> > > Indeed, commenting out these 2 lines in
> > > arch/arm/boot/dts/imx6qdl-wandboard.dtsi fixes my problem without having
> > > to increase TX_RING_SIZE.
> > > Thank you very much!
> > 
> > Could you please send a patch for imx6qdl-wandboard.dtsi? Please
> > provide the details of the problem in the commit log.
> > 
> > Thanks

Ok, here is my attempt on the patch. I've also removed the respective lines from all the other imx6qdl-*.dtsi files.

Signed-off-by: Thomas Scheiblauer <tom@sharkbay.at>
---
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 2 --
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi  | 2 --
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi  | 2 --
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi  | 2 --
 4 files changed, 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index 42ff525..cf4e6db 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -169,8 +169,6 @@
 	txd1-skew-ps = <0>;
 	txd2-skew-ps = <0>;
 	txd3-skew-ps = <0>;
-	interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_HIGH>,
-			      <&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 009abd6..f47e82f 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -65,8 +65,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
-	interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_HIGH>,
-			      <&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index 0a36129..ebfcab4 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -168,8 +168,6 @@
 	txd1-skew-ps = <0>;
 	txd2-skew-ps = <0>;
 	txd3-skew-ps = <0>;
-	interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_HIGH>,
-			      <&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
index 6461f66..3b61c9a 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
@@ -257,8 +257,6 @@
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
 	phy-reset-gpios = <&gpio3 29 0>;
-	interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_HIGH>,
-			      <&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
 	status = "okay";
 };
 
-- 
2.0.2
