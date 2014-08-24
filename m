From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Sun, 24 Aug 2014 23:24:45 +0200
Subject: [RFC 7/7] ARM: BCM5301X: register bcma bus
In-Reply-To: <1408915485-8078-1-git-send-email-hauke@hauke-m.de>
References: <1408915485-8078-1-git-send-email-hauke@hauke-m.de>
Message-ID: <1408915485-8078-9-git-send-email-hauke@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 arch/arm/boot/dts/bcm4708.dtsi | 58 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm/boot/dts/bcm4708.dtsi b/arch/arm/boot/dts/bcm4708.dtsi
index 31141e8..7c240ab 100644
--- a/arch/arm/boot/dts/bcm4708.dtsi
+++ b/arch/arm/boot/dts/bcm4708.dtsi
@@ -31,4 +31,62 @@
 		};
 	};
 
+	nvram0: nvram at 0 {
+		compatible = "brcm,bcm47xx-nvram";
+		reg = <0x1c000000 0x01000000>;
+	};
+
+	sprom0: sprom at 0 {
+		compatible = "brcm,bcm47xx-sprom";
+		nvram = <&nvram0>;
+	};
+
+	aix at 18000000 {
+		compatible = "brcm,bus-aix";
+		reg = <0x18000000 0x1000>;
+		ranges = <0x00000000 0x18000000 0x00100000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		sprom = <&sprom0>;
+
+		usb2 at 0 {
+			reg = <0x18021000 0x1000>;
+			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		usb3 at 0 {
+			reg = <0x18023000 0x1000>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		gmac at 0 {
+			reg = <0x18024000 0x1000>;
+			interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		gmac at 1 {
+			reg = <0x18025000 0x1000>;
+			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		gmac at 2 {
+			reg = <0x18026000 0x1000>;
+			interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		gmac at 3 {
+			reg = <0x18027000 0x1000>;
+			interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pcie at 0 {
+			reg = <0x18012000 0x1000>;
+			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pcie at 1 {
+			reg = <0x18013000 0x1000>;
+			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
 };
-- 
1.9.1
