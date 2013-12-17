From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Mon, 16 Dec 2013 18:12:57 -0700
Subject: [PATCH V2 07/13] ARM: dts: imx6qdl-sabrelite: explicitly set pad for
 SGTL5000 sys_mclk
In-Reply-To: <1387242783-1462-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1387242783-1462-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1387242783-1462-8-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Explicitly sets the pad GPIO_0 (sys_mclk) to 0x030b0.

Before this patch, it has the value 0x130b0 if using mainline u-boot.
So this patch also removes hysteresis. The 100k pulldown remains so
that a disabled clock will be low.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

---
v2: New patch.. V1 patch to add comments was broken up into
multiple patches
---
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index ee3f5c0..29f0b40 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -114,7 +114,8 @@
 	imx6q-sabrelite {
 		pinctrl_hog: hoggrp {
 			fsl,pins = <
-				MX6QDL_PAD_GPIO_0__CCM_CLKO1    0x80000000
+				/* SGTL5000 sys_mclk */
+				MX6QDL_PAD_GPIO_0__CCM_CLKO1    0x030b0
 			>;
 		};
 
-- 
1.8.1.2
