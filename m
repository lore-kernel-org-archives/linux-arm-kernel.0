From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 27 Apr 2016 17:46:29 +0200
Subject: [PATCH 3/3] arm64: dts: marvell: Use a SoC-specific compatible for
 xHCI on Armada37xx
In-Reply-To: <1461771989-15662-1-git-send-email-gregory.clement@free-electrons.com>
References: <1461771989-15662-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1461771989-15662-4-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even if the Armada 37xx does not any specific setup, the device tree
binding documentation requires to use a SoC-specific version
corresponding to the platform first followed by the generic version.

This patch introduce this new compatible string and updates the
documentation accordingly.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 Documentation/devicetree/bindings/usb/usb-xhci.txt | 1 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
index 6a17aa85c4d5..966885c636d0 100644
--- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
@@ -4,6 +4,7 @@ Required properties:
   - compatible: should be one or more of
 
     - "generic-xhci" for generic XHCI device
+    - "marvell,armada3700-xhci" for Armada 37xx SoCs
     - "marvell,armada-375-xhci" for Armada 375 SoCs
     - "marvell,armada-380-xhci" for Armada 38x SoCs
     - "renesas,xhci-r8a7790" for r8a7790 SoC
diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 55a861d60fae..1d4fb4d27787 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -106,7 +106,8 @@
 			};
 
 			usb3: usb at 58000 {
-				compatible = "generic-xhci";
+				compatible = "marvell,armada3700-xhci",
+				"generic-xhci";
 				reg = <0x58000 0x4000>;
 				interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
-- 
2.5.0
