From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:50:50 +0900
Subject: [PATCH 20/34] ARM: shmobile: r8a7790: add USB3.0 device node
In-Reply-To: <cover.1415059587.git.horms+renesas@verge.net.au>
References: <cover.1415059587.git.horms+renesas@verge.net.au>
Message-ID: <157fcd8a3e6fb46ad99b615838afe16e8fcebd61.1415059587.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 050e608..ad5df80 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1186,6 +1186,16 @@
 		status = "disabled";
 	};
 
+	xhci: usb at ee000000 {
+		compatible = "renesas,xhci-r8a7790";
+		reg = <0 0xee000000 0 0xc00>;
+		interrupts = <0 101 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7790_CLK_SSUSB>;
+		phys = <&usb2 1>;
+		phy-names = "usb";
+		status = "disabled";
+	};
+
 	pci0: pci at ee090000 {
 		compatible = "renesas,pci-r8a7790";
 		device_type = "pci";
-- 
2.1.1
