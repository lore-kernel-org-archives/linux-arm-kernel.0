From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 13 Feb 2013 12:26:36 +0900
Subject: [PATCH 18/21] ARM: shmobile: sh73a0: Remove FSI function GPIOs
In-Reply-To: <1360725999-14514-1-git-send-email-horms+renesas@verge.net.au>
References: <1360725999-14514-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1360725999-14514-19-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Those GPIOs have been deprecated by the pinctrl API. They are unused and
unneeded, remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/sh73a0.h |   31 ++++++++------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/sh73a0.h b/arch/arm/mach-shmobile/include/mach/sh73a0.h
index 8e4e469..a256372 100644
--- a/arch/arm/mach-shmobile/include/mach/sh73a0.h
+++ b/arch/arm/mach-shmobile/include/mach/sh73a0.h
@@ -105,7 +105,7 @@ enum {
 	GPIO_FN_GPI7,
 	GPIO_FN_GPO7, GPIO_FN_MFG0_OUT2,
 	GPIO_FN_GPO6, GPIO_FN_MFG1_OUT2,
-	GPIO_FN_GPO5, GPIO_FN_FSICOSLDT3,
+	GPIO_FN_GPO5,
 	GPIO_FN_PORT16_VIO_CKOR,
 	GPIO_FN_PORT19_VIO_CKO2,
 	GPIO_FN_GPO0,
@@ -123,29 +123,16 @@ enum {
 	GPIO_FN_SIM_CLK, GPIO_FN_PORT30_VIO_CKOR,
 	GPIO_FN_SIM_D, GPIO_FN_PORT31_IROUT,
 	GPIO_FN_XWUP,
-	GPIO_FN_FSIBOBT, GPIO_FN_FSIBIBT,
-	GPIO_FN_FSIBOLR, GPIO_FN_FSIBILR,
-	GPIO_FN_FSIBOSLD,
-	GPIO_FN_FSIBISLD,
 	GPIO_FN_VACK,
 	GPIO_FN_XTAL1L,
-	GPIO_FN_FSICOSLDT2,
-	GPIO_FN_FSICOSLDT1,
-	GPIO_FN_FSICOBT, GPIO_FN_FSICIBT, GPIO_FN_FSIDOBT, GPIO_FN_FSIDIBT,
-	GPIO_FN_FSICOLR, GPIO_FN_FSICILR, GPIO_FN_FSIDOLR, GPIO_FN_FSIDILR,
-	GPIO_FN_FSICOSLD, GPIO_FN_PORT47_FSICSPDIF,
-	GPIO_FN_FSICISLD, GPIO_FN_FSIDISLD,
-	GPIO_FN_FSIACK, GPIO_FN_PORT49_IRDA_OUT, GPIO_FN_PORT49_IROUT, \
-	GPIO_FN_FSIAOMC,
-	GPIO_FN_FSIAOLR, GPIO_FN_BBIF2_TSYNC2, GPIO_FN_TPU2TO2, GPIO_FN_FSIAILR,
-
-	GPIO_FN_FSIAOBT, GPIO_FN_BBIF2_TSCK2, GPIO_FN_TPU2TO3, GPIO_FN_FSIAIBT,
-	GPIO_FN_FSIAOSLD, GPIO_FN_BBIF2_TXD2,
-	GPIO_FN_FSIASPDIF, GPIO_FN_PORT53_IRDA_IN, GPIO_FN_TPU3TO3, \
-	GPIO_FN_FSIBSPDIF, GPIO_FN_PORT53_FSICSPDIF,
-	GPIO_FN_FSIBCK, GPIO_FN_PORT54_IRDA_FIRSEL, GPIO_FN_TPU3TO2, \
-	GPIO_FN_FSIBOMC, GPIO_FN_FSICCK, GPIO_FN_FSICOMC,
-	GPIO_FN_FSIAISLD, GPIO_FN_TPU0TO0,
+	GPIO_FN_PORT49_IRDA_OUT, GPIO_FN_PORT49_IROUT,
+	GPIO_FN_BBIF2_TSYNC2, GPIO_FN_TPU2TO2,
+
+	GPIO_FN_BBIF2_TSCK2, GPIO_FN_TPU2TO3,
+	GPIO_FN_BBIF2_TXD2,
+	GPIO_FN_PORT53_IRDA_IN, GPIO_FN_TPU3TO3,
+	GPIO_FN_PORT54_IRDA_FIRSEL, GPIO_FN_TPU3TO2,
+	GPIO_FN_TPU0TO0,
 	GPIO_FN_A0, GPIO_FN_BS_,
 	GPIO_FN_A12, GPIO_FN_PORT58_KEYOUT7, GPIO_FN_TPU4TO2,
 	GPIO_FN_A13, GPIO_FN_PORT59_KEYOUT6, GPIO_FN_TPU0TO1,
-- 
1.7.10.4
