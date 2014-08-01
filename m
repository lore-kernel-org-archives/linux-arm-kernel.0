From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri,  1 Aug 2014 06:54:48 +0200
Subject: [PATCH v5 01/10] ARM: dts: Fix MMC pinctrl for exynos5250-snow
In-Reply-To: <1406868897-26874-1-git-send-email-afaerber@suse.de>
References: <1406868897-26874-1-git-send-email-afaerber@suse.de>
Message-ID: <1406868897-26874-2-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pinctrl properties should be on the device directly and not on the
slot sub-node.

Reported-by: Doug Anderson <dianders@chromium.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v3 -> v4 -> v5: Unchanged
 
 v3: New (Doug Anderson)
 Redundant with Jaehoon Chung's general slot at 0 deprecation,
 in case that hits the tree earlier.

 arch/arm/boot/dts/exynos5250-snow.dts | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index f2b8c4116541..eb437f6afec1 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -240,10 +240,8 @@
 	 */
 	mmc at 12230000 {
 		status = "okay";
-		slot at 0 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&sd3_clk &sd3_cmd &sd3_bus4>;
-		};
+		pinctrl-names = "default";
+		pinctrl-0 = <&sd3_clk &sd3_cmd &sd3_bus4>;
 	};
 
 	i2c at 12CD0000 {
-- 
1.9.3
