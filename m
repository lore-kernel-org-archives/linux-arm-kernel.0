From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue,  5 Feb 2013 21:54:54 +0100
Subject: [PATCH 1/2] arm: mvebu: Add SPI flash on Armada XP-DB board
In-Reply-To: <1360097695-32663-1-git-send-email-gregory.clement@free-electrons.com>
References: <1360097695-32663-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1360097695-32663-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add support for the SPI flash M25P64 which is present on
the Armada XP DB board. This flash stores the bootloader and its
environment.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-db.dts |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index c7035c5..e5dfb4f 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -97,5 +97,17 @@
 			status = "okay";
 			/* No CD or WP GPIOs */
 		};
+
+		spi0: spi at d0010600 {
+			status = "okay";
+
+			spi-flash at 0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "m25p64";
+				reg = <0>; /* Chip select 0 */
+				spi-max-frequency = <20000000>;
+			};
+		};
 	};
 };
-- 
1.7.9.5
