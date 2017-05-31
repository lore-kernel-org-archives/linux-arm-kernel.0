From: raviteja.garimella@broadcom.com (Raviteja Garimella)
Date: Wed, 31 May 2017 15:42:03 +0530
Subject: [PATCH v6 3/3] arm64: dts: NS2: Add USB DRD PHY device tree node
In-Reply-To: <1496225523-22035-1-git-send-email-raviteja.garimella@broadcom.com>
References: <1496225523-22035-1-git-send-email-raviteja.garimella@broadcom.com>
Message-ID: <1496225523-22035-4-git-send-email-raviteja.garimella@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree node for USB Dual Role Device Phy for
Broadcom's Northstar2 SoC.

Signed-off-by: Raviteja Garimella <raviteja.garimella@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/ns2.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
index 35a309a..35c8457 100644
--- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -460,6 +460,20 @@
 			};
 		};
 
+		usbdrd_phy: phy at 66000960 {
+			#phy-cells = <0>;
+			compatible = "brcm,ns2-drd-phy";
+			reg = <0x66000960 0x24>,
+			      <0x67012800 0x4>,
+			      <0x6501d148 0x4>,
+			      <0x664d0700 0x4>;
+			reg-names = "icfg", "rst-ctrl",
+				    "crmu-ctrl", "usb2-strap";
+			id-gpios = <&gpio_g 30 0>;
+			vbus-gpios = <&gpio_g 31 0>;
+			status = "disabled";
+		};
+
 		pwm: pwm at 66010000 {
 			compatible = "brcm,iproc-pwm";
 			reg = <0x66010000 0x28>;
-- 
2.1.0
