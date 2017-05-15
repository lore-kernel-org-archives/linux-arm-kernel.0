From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 15 May 2017 10:50:00 +0200
Subject: [PATCH] arm64: allwinner: h5: Remove syslink to shared DTSI
Message-ID: <20170515085000.27965-1-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm64 H5 and arm H3 SoCs share roughly the same base, and therefore
share a significant part of their device tree.

The approach we took was to add a symlink from the arm64 DTSI to the arm
DTSI.

Now that the arm DT folder is exposed in the include path, we can just use
it and remove our symlink.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi   | 2 +-
 arch/arm64/boot/dts/allwinner/sunxi-h3-h5.dtsi | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)
 delete mode 120000 arch/arm64/boot/dts/allwinner/sunxi-h3-h5.dtsi

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
index 4d314a253fd9..732e2e06f503 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
@@ -40,7 +40,7 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include "sunxi-h3-h5.dtsi"
+#include <arm/sunxi-h3-h5.dtsi>
 
 / {
 	cpus {
diff --git a/arch/arm64/boot/dts/allwinner/sunxi-h3-h5.dtsi b/arch/arm64/boot/dts/allwinner/sunxi-h3-h5.dtsi
deleted file mode 120000
index 036f01dc2b9b..000000000000
--- a/arch/arm64/boot/dts/allwinner/sunxi-h3-h5.dtsi
+++ /dev/null
@@ -1 +0,0 @@
-../../../../arm/boot/dts/sunxi-h3-h5.dtsi
\ No newline at end of file
-- 
2.9.3
