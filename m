From: jianwei.wang@freescale.com (Jianwei Wang)
Date: Mon, 13 Jul 2015 18:51:31 +0800
Subject: [PATCH v9 3/4] arm/dts/ls1021a: Add DCU dts node
In-Reply-To: <1436784692-40560-1-git-send-email-jianwei.wang@freescale.com>
References: <1436784692-40560-1-git-send-email-jianwei.wang@freescale.com>
Message-ID: <1436784692-40560-3-git-send-email-jianwei.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DCU node, DCU is a display controller of Freescale
named 2D-ACE.

Signed-off-by: Alison Wang <b18965@freescale.com>
Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
Signed-off-by: Jianwei Wang <b52261@freescale.com>
Reviewed-by: Alison Wang <alison.wang@freescale.com>
---
 .../devicetree/bindings/drm/fsl-dcu/fsl,dcu.txt      | 20 ++++++++++++++++++++
 MAINTAINERS                                          |  1 +
 arch/arm/boot/dts/ls1021a.dtsi                       | 10 ++++++++++
 3 files changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/drm/fsl-dcu/fsl,dcu.txt

diff --git a/Documentation/devicetree/bindings/drm/fsl-dcu/fsl,dcu.txt b/Documentation/devicetree/bindings/drm/fsl-dcu/fsl,dcu.txt
new file mode 100644
index 0000000..eb61ea5
--- /dev/null
+++ b/Documentation/devicetree/bindings/drm/fsl-dcu/fsl,dcu.txt
@@ -0,0 +1,20 @@
+Device Tree bindings for Freescale DCU DRM Driver
+
+Required properties:
+- compatible:           Should be one of
+	* "fsl,ls1021a-dcu".
+	* "fsl,vf610-dcu".
+- reg:                  Address and length of the register set for dcu.
+- clocks:               From common clock binding: handle to dcu clock.
+- clock-names:          From common clock binding: Shall be "dcu".
+- panel:		The phandle to panel node.
+
+Examples:
+dcu: dcu at 2ce0000 {
+	compatible = "fsl,ls1021a-dcu";
+	reg = <0x0 0x2ce0000 0x0 0x10000>;
+	clocks = <&platform_clk 0>;
+	clock-names = "dcu";
+	big-endian;
+	panel = <&panel>;
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index e191ded..fffb8c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3410,6 +3410,7 @@ M:	Alison Wang <alison.wang@freescale.com>
 L:	dri-devel at lists.freedesktop.org
 S:	Supported
 F:	drivers/gpu/drm/fsl-dcu/
+F:      Documentation/devicetree/bindings/drm/fsl-dcu/
 F:      Documentation/devicetree/bindings/panel/nec,nl4827hc19_05b.txt
 
 DRM DRIVERS FOR NVIDIA TEGRA
diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index c70bb27..6d6e3e2 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -383,6 +383,16 @@
 				 <&platform_clk 1>;
 		};
 
+		dcu: dcu at 2ce0000 {
+			compatible = "fsl,ls1021a-dcu";
+			reg = <0x0 0x2ce0000 0x0 0x10000>;
+			interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&platform_clk 0>;
+			clock-names = "dcu";
+			big-endian;
+			status = "disabled";
+		};
+
 		mdio0: mdio at 2d24000 {
 			compatible = "gianfar";
 			device_type = "mdio";
-- 
2.1.0.27.g96db324
