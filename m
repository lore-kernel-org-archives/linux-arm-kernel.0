From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Wed, 30 Dec 2015 15:39:02 +0200
Subject: [PATCH 3/6] ARM: dts: am57xx: cl-som-am57x: update SPI Flash frequency
In-Reply-To: <1451482745-1820-1-git-send-email-lifshitz@compulab.co.il>
References: <1451482745-1820-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1451482745-1820-4-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On-board SPI flash cat act at 48Mhz SPI bus frequency.
Update the DT frequency property.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
index 513ec62..cb9a518 100644
--- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
@@ -492,14 +492,14 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&qspi1_pins>;
 
-	spi-max-frequency = <20000000>;
+	spi-max-frequency = <48000000>;
 
 	spi_flash: spi_flash at 0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spansion,m25p80", "jedec,spi-nor";
 		reg = <0>;				/* CS0 */
-		spi-max-frequency = <20000000>;
+		spi-max-frequency = <48000000>;
 
 		partition at 0 {
 			label = "uboot";
-- 
1.9.1
