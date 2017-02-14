From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Tue, 14 Feb 2017 17:49:06 +0100
Subject: [PATCH 2/2] ARM: dts: BCM53573: Add Tenda AC9 2 GHz LED
In-Reply-To: <20170214164906.19245-1-zajec5@gmail.com>
References: <20170214164906.19245-1-zajec5@gmail.com>
Message-ID: <20170214164906.19245-2-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

It's connected to a GPIO pin of an extra controller placed on the PCIe
card.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 arch/arm/boot/dts/bcm47189-tenda-ac9.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/bcm47189-tenda-ac9.dts b/arch/arm/boot/dts/bcm47189-tenda-ac9.dts
index ce8c155fcc01..6bdd79567cbd 100644
--- a/arch/arm/boot/dts/bcm47189-tenda-ac9.dts
+++ b/arch/arm/boot/dts/bcm47189-tenda-ac9.dts
@@ -48,6 +48,16 @@
 		};
 	};
 
+	pcie0_leds {
+		compatible = "gpio-leds";
+
+		2ghz {
+			label = "bcm53xx:blue:2ghz";
+			gpios = <&pcie0_chipcommon 3 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-off";
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		#address-cells = <1>;
-- 
2.11.0
