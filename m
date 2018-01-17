From: jramirez@baylibre.com (Jorge Ramirez-Ortiz)
Date: Wed, 17 Jan 2018 11:55:43 +0100
Subject: [PATCH v2] ARM64: dts: meson s905x: accept MAC addr from u-boot
 environment
Message-ID: <1516186543-22056-1-git-send-email-jramirez@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the adequate configuration settings, u-boot will loop through the
list of aliases looking for "ethernetX".

By adding an ethernet alias, u-boot can fixup the local-mac-address
property in the kernel's device tree using a value held in its
environment variable ethaddr.

Tested-by: Jorge Ramirez-Ortiz <jramirez@baylibre.com>
Signed-off-by: Jorge Ramirez-Ortiz <jramirez@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index 68d2c90..278d769 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -18,6 +18,7 @@
 
 	aliases {
 		serial0 = &uart_AO;
+		ethernet0 = &ethmac;
 	};
 
 	chosen {
-- 
2.7.4
