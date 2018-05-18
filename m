From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:16:34 +0200
Subject: [PATCH 01/69] ARM: dts: r7s72100: add USB device to device tree
In-Reply-To: <cover.1526641667.git.horms+renesas@verge.net.au>
References: <cover.1526641667.git.horms+renesas@verge.net.au>
Message-ID: <f8ce138029058fb7b144b866ae5cdb98db58f4fb.1526641667.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Brandt <chris.brandt@renesas.com>

Add USB device support.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index ab9645a42eca..bd6366d1800b 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -667,4 +667,24 @@
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
+
+	usbhs0: usb at e8010000 {
+		compatible = "renesas,usbhs-r7s72100", "renesas,rza1-usbhs";
+		reg = <0xe8010000 0x1a0>;
+		interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R7S72100_CLK_USB0>;
+		renesas,buswait = <4>;
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
+	usbhs1: usb at e8207000 {
+		compatible = "renesas,usbhs-r7s72100", "renesas,rza1-usbhs";
+		reg = <0xe8207000 0x1a0>;
+		interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R7S72100_CLK_USB1>;
+		renesas,buswait = <4>;
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
 };
-- 
2.11.0
