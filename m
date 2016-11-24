From: fparent@baylibre.com (Fabien Parent)
Date: Thu, 24 Nov 2016 15:35:45 +0100
Subject: [PATCH] ARM: dts: da850-lcdk: Add ethernet0 alias to DT
Message-ID: <20161124143545.12817-1-fparent@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to avoid Linux generating a random mac address on every boot,
add an ethernet0 alias that will allow u-boot to patch the dtb with
the MAC address programmed into the EEPROM.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 arch/arm/boot/dts/da850-lcdk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index 7b8ab21..18dfec93 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -13,6 +13,7 @@
 
 	aliases {
 		serial2 = &serial2;
+		ethernet0 = &eth0;
 	};
 
 	chosen {
-- 
2.10.2
