From: atx@atx.name (Josef Gajdusek)
Date: Mon, 23 Nov 2015 09:02:48 +0100
Subject: [PATCH v2 1/5] ARM: dts: sun8i: Add SID node
In-Reply-To: <cover.1448263428.git.atx@atx.name>
References: <cover.1448263428.git.atx@atx.name>
Message-ID: <b897b1c8741c8a871163b84d01b480f99329536d.1448263428.git.atx@atx.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node describing the Security ID memory to the
Allwinner H3 .dtsi file.

Signed-off-by: Josef Gajdusek <atx@atx.name>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 0faa38a..58de718 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -359,6 +359,13 @@
 			#size-cells = <0>;
 		};
 
+		sid: eeprom at 01c14000 {
+			compatible = "allwinner,sun4i-a10-sid";
+			reg = <0x01c14000 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		usbphy: phy at 01c19400 {
 			compatible = "allwinner,sun8i-h3-usb-phy";
 			reg = <0x01c19400 0x2c>,
-- 
2.4.10
