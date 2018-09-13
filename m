From: robh@kernel.org (Rob Herring)
Date: Thu, 13 Sep 2018 13:12:33 -0500
Subject: [PATCH] ARM: dts: lpc32xx: Fix SPI controller node names
Message-ID: <20180913181245.25484-9-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SPI controller nodes should be named 'spi' rather than 'ssp'. Fixing the
name enables dtc SPI bus checks.

Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---

 arch/arm/boot/dts/lpc32xx.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index abff7ef7c9cd..b7303a4e4236 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -179,7 +179,7 @@
 			 * ssp0 and spi1 are shared pins;
 			 * enable one in your board dts, as needed.
 			 */
-			ssp0: ssp at 20084000 {
+			ssp0: spi at 20084000 {
 				compatible = "arm,pl022", "arm,primecell";
 				reg = <0x20084000 0x1000>;
 				interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
@@ -199,7 +199,7 @@
 			 * ssp1 and spi2 are shared pins;
 			 * enable one in your board dts, as needed.
 			 */
-			ssp1: ssp at 2008c000 {
+			ssp1: spi at 2008c000 {
 				compatible = "arm,pl022", "arm,primecell";
 				reg = <0x2008c000 0x1000>;
 				interrupts = <21 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.17.1
