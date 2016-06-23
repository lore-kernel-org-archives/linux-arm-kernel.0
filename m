From: megous@megous.com (megous at megous.com)
Date: Thu, 23 Jun 2016 21:20:51 +0200
Subject: [PATCH 01/14] ARM: dts: sun8i: Add SID node
In-Reply-To: <20160623192104.18720-1-megous@megous.com>
References: <20160623192104.18720-1-megous@megous.com>
Message-ID: <20160623192104.18720-2-megous@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Josef Gajdusek <atx@atx.name>

Add a node describing the Security ID memory to the Allwinner H3 .dtsi file.

Signed-off-by: Josef Gajdusek <atx@atx.name>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 4a4926b..172576d 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -389,6 +389,13 @@
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
2.9.0
