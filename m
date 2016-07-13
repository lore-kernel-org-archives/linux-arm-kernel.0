From: sr@denx.de (Stefan Roese)
Date: Wed, 13 Jul 2016 11:55:19 +0200
Subject: [PATCH 3/3 v2] ARM: dts: mvebu: armada-370-xp: Add MBus mappings for
 all SPI devices
In-Reply-To: <20160713095519.30790-1-sr@denx.de>
References: <20160713095519.30790-1-sr@denx.de>
Message-ID: <20160713095519.30790-3-sr@denx.de>
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
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
v2:
- Rebased on v4.7-rc7
- Added "<" and ">" around all MBUS_ID lines as suggested by Arnd

 arch/arm/boot/dts/armada-370-xp.dtsi | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index a0903cd..3ccedc9 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -302,7 +302,15 @@
 		};
 
 		spi0: spi at 10600 {
-			reg = <MBUS_ID(0xf0, 0x01) 0x10600 0x28>;
+			reg = <MBUS_ID(0xf0, 0x01) 0x10600 0x28>, /* control */
+			      <MBUS_ID(0x01, 0x1e) 0 0xffffffff>, /* CS0 */
+			      <MBUS_ID(0x01, 0x5e) 0 0xffffffff>, /* CS1 */
+			      <MBUS_ID(0x01, 0x9e) 0 0xffffffff>, /* CS2 */
+			      <MBUS_ID(0x01, 0xde) 0 0xffffffff>, /* CS3 */
+			      <MBUS_ID(0x01, 0x1f) 0 0xffffffff>, /* CS4 */
+			      <MBUS_ID(0x01, 0x5f) 0 0xffffffff>, /* CS5 */
+			      <MBUS_ID(0x01, 0x9f) 0 0xffffffff>, /* CS6 */
+			      <MBUS_ID(0x01, 0xdf) 0 0xffffffff>; /* CS7 */
 			#address-cells = <1>;
 			#size-cells = <0>;
 			cell-index = <0>;
@@ -312,7 +320,15 @@
 		};
 
 		spi1: spi at 10680 {
-			reg = <MBUS_ID(0xf0, 0x01) 0x10680 0x28>;
+			reg = <MBUS_ID(0xf0, 0x01) 0x10680 0x28>, /* control */
+			      <MBUS_ID(0x01, 0x1a) 0 0xffffffff>, /* CS0 */
+			      <MBUS_ID(0x01, 0x5a) 0 0xffffffff>, /* CS1 */
+			      <MBUS_ID(0x01, 0x9a) 0 0xffffffff>, /* CS2 */
+			      <MBUS_ID(0x01, 0xda) 0 0xffffffff>, /* CS3 */
+			      <MBUS_ID(0x01, 0x1b) 0 0xffffffff>, /* CS4 */
+			      <MBUS_ID(0x01, 0x5b) 0 0xffffffff>, /* CS5 */
+			      <MBUS_ID(0x01, 0x9b) 0 0xffffffff>, /* CS6 */
+			      <MBUS_ID(0x01, 0xdb) 0 0xffffffff>; /* CS7 */
 			#address-cells = <1>;
 			#size-cells = <0>;
 			cell-index = <1>;
-- 
2.9.1
