From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue,  5 Feb 2013 21:54:55 +0100
Subject: [PATCH 2/2] arm: mvebu: Add SPI flash on Armada 370 DB board
In-Reply-To: <1360097695-32663-1-git-send-email-gregory.clement@free-electrons.com>
References: <1360097695-32663-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1360097695-32663-3-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add support for the SPI flash MX25l25635E which is present
on the Armada 370 DB board. This flash stores the bootloader and its
environment.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-db.dts |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index 8e66a7c..d3ff947 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -74,5 +74,16 @@
 			status = "disabled";
 			/* No CD or WP GPIOs */
 		};
+		spi0: spi at d0010600 {
+			status = "okay";
+
+			spi-flash at 0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "mx25l25635e";
+				reg = <0>; /* Chip select 0 */
+				spi-max-frequency = <50000000>;
+			};
+		};
 	};
 };
-- 
1.7.9.5
