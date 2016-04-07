From: sr@denx.de (Stefan Roese)
Date: Thu,  7 Apr 2016 14:02:17 +0200
Subject: [PATCH 2/2] ARM: dts: mvebu: armada-370-xp: Add MBus mappings for all
 SPI devices
In-Reply-To: <1460030537-10054-1-git-send-email-sr@denx.de>
References: <1460030537-10054-1-git-send-email-sr@denx.de>
Message-ID: <1460030537-10054-2-git-send-email-sr@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the static MBus mappings for all supported SPI devices
(8 per controller) for the direct access SPI mode. They can be configured
and enabled by setting these MBus mapping in the 'ranges' property of the
per-board 'soc' node. If nothing is changed here, the default 'normal'
(indirect) SPI mode is used.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason@lakedameon.net>
Cc: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/armada-370-xp.dtsi | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index a0903cd..c3ebf88 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -302,7 +302,15 @@
 		};
 
 		spi0: spi at 10600 {
-			reg = <MBUS_ID(0xf0, 0x01) 0x10600 0x28>;
+			reg = <MBUS_ID(0xf0, 0x01) 0x10600 0x28	/* control */
+			       MBUS_ID(0x01, 0x1e) 0 0x100000	/* CS0 */
+			       MBUS_ID(0x01, 0x5e) 0 0x100000	/* CS1 */
+			       MBUS_ID(0x01, 0x9e) 0 0x100000	/* CS2 */
+			       MBUS_ID(0x01, 0xde) 0 0x100000	/* CS3 */
+			       MBUS_ID(0x01, 0x1f) 0 0x100000	/* CS4 */
+			       MBUS_ID(0x01, 0x5f) 0 0x100000	/* CS5 */
+			       MBUS_ID(0x01, 0x9f) 0 0x100000	/* CS6 */
+			       MBUS_ID(0x01, 0xdf) 0 0x100000>;	/* CS7 */
 			#address-cells = <1>;
 			#size-cells = <0>;
 			cell-index = <0>;
@@ -312,7 +320,15 @@
 		};
 
 		spi1: spi at 10680 {
-			reg = <MBUS_ID(0xf0, 0x01) 0x10680 0x28>;
+			reg = <MBUS_ID(0xf0, 0x01) 0x10680 0x28	/* control */
+			       MBUS_ID(0x01, 0x1a) 0 0x100000	/* CS0 */
+			       MBUS_ID(0x01, 0x5a) 0 0x100000	/* CS1 */
+			       MBUS_ID(0x01, 0x9a) 0 0x100000	/* CS2 */
+			       MBUS_ID(0x01, 0xda) 0 0x100000	/* CS3 */
+			       MBUS_ID(0x01, 0x1b) 0 0x100000	/* CS4 */
+			       MBUS_ID(0x01, 0x5b) 0 0x100000	/* CS5 */
+			       MBUS_ID(0x01, 0x9b) 0 0x100000	/* CS6 */
+			       MBUS_ID(0x01, 0xdb) 0 0x100000>;	/* CS7 */
 			#address-cells = <1>;
 			#size-cells = <0>;
 			cell-index = <1>;
-- 
2.8.1
