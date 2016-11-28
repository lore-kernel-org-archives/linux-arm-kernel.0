From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 28 Nov 2016 10:25:26 -0800
Subject: [PATCH] ARM64: dts: meson-gxbb: add SCPI pre-1.0 compatible
Message-ID: <20161128182526.1386-1-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SCPI driver has an updated compatible to indicate the pre-released
(pre v1.0) status of the driver.  Since Amlogic used a pre-1.0
version, add that compatible as well.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index ac5ad3bf1bd6..51edd5b5c460 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -51,7 +51,7 @@
 	compatible = "amlogic,meson-gxbb";
 
 	scpi {
-		compatible = "amlogic,meson-gxbb-scpi";
+		compatible = "amlogic,meson-gxbb-scpi", "arm,scpi-pre-1.0";
 		mboxes = <&mailbox 1 &mailbox 2>;
 		shmem = <&cpu_scp_lpri &cpu_scp_hpri>;
 
-- 
2.9.3
