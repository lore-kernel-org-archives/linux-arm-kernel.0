From: romain.perier@collabora.com (Romain Perier)
Date: Fri, 30 Jun 2017 15:35:57 +0200
Subject: [PATCH] ARM: dts: imx6q-bx50v3: disable SD card
Message-ID: <20170630133557.17129-1-romain.perier@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ian Ray <ian.ray@ge.com>

Default boot medium must be internal eMMC, we don't want the SDIO to be
used for these devices. This commit disables the SD card interface
for GE Healthcare Bx50v3 devices.

Signed-off-by: Ian Ray <ian.ray@ge.com>
Signed-off-by: Romain Perier <romain.perier@collabora.com>
---
 arch/arm/boot/dts/imx6q-bx50v3.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-bx50v3.dtsi b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
index 75201ca..25466372 100644
--- a/arch/arm/boot/dts/imx6q-bx50v3.dtsi
+++ b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
@@ -326,3 +326,7 @@
 		tcxo-clock-frequency = <26000000>;
 	};
 };
+
+&usdhc2 {
+	status = "disabled";
+};
-- 
1.8.3.1
