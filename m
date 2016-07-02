From: akurz@blala.de (Alexander Kurz)
Date: Sat,  2 Jul 2016 14:02:31 +0200
Subject: [PATCH 2/2] ARM i.MX31 iomux: remove duplicates with alternate name
In-Reply-To: <1467460951-9173-1-git-send-email-akurz@blala.de>
References: <1467460951-9173-1-git-send-email-akurz@blala.de>
Message-ID: <1467460951-9173-2-git-send-email-akurz@blala.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Three iomux were accessinble with two distinct names, typo?
Remove the unused duplicates and fix the typo.

Signed-off-by: Alexander Kurz <akurz@blala.de>
---
 arch/arm/mach-imx/iomux-mx3.h   | 3 ---
 arch/arm/mach-imx/mach-pcm037.c | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/iomux-mx3.h b/arch/arm/mach-imx/iomux-mx3.h
index a52c051..368667b 100644
--- a/arch/arm/mach-imx/iomux-mx3.h
+++ b/arch/arm/mach-imx/iomux-mx3.h
@@ -598,10 +598,7 @@ enum iomux_pins {
 #define MX31_PIN_CONTRAST__CONTRAST	IOMUX_MODE(MX31_PIN_CONTRAST, IOMUX_CONFIG_FUNC)
 #define MX31_PIN_D3_SPL__D3_SPL		IOMUX_MODE(MX31_PIN_D3_SPL, IOMUX_CONFIG_FUNC)
 #define MX31_PIN_D3_CLS__D3_CLS		IOMUX_MODE(MX31_PIN_D3_CLS, IOMUX_CONFIG_FUNC)
-#define MX31_PIN_LCS0__GPI03_23		IOMUX_MODE(MX31_PIN_LCS0, IOMUX_CONFIG_GPIO)
 #define MX31_PIN_GPIO1_1__GPIO          IOMUX_MODE(MX31_PIN_GPIO1_1, IOMUX_CONFIG_GPIO)
-#define MX31_PIN_I2C_CLK__SCL		IOMUX_MODE(MX31_PIN_I2C_CLK, IOMUX_CONFIG_FUNC)
-#define MX31_PIN_I2C_DAT__SDA		IOMUX_MODE(MX31_PIN_I2C_DAT, IOMUX_CONFIG_FUNC)
 #define MX31_PIN_DCD_DTE1__I2C2_SDA	IOMUX_MODE(MX31_PIN_DCD_DTE1, IOMUX_CONFIG_ALT2)
 #define MX31_PIN_RI_DTE1__I2C2_SCL	IOMUX_MODE(MX31_PIN_RI_DTE1, IOMUX_CONFIG_ALT2)
 #define MX31_PIN_CSPI2_SS2__I2C3_SDA	IOMUX_MODE(MX31_PIN_CSPI2_SS2, IOMUX_CONFIG_ALT1)
diff --git a/arch/arm/mach-imx/mach-pcm037.c b/arch/arm/mach-imx/mach-pcm037.c
index 6d87941..a159a77 100644
--- a/arch/arm/mach-imx/mach-pcm037.c
+++ b/arch/arm/mach-imx/mach-pcm037.c
@@ -149,7 +149,7 @@ static unsigned int pcm037_pins[] = {
 	MX31_PIN_CONTRAST__CONTRAST,
 	MX31_PIN_D3_SPL__D3_SPL,
 	MX31_PIN_D3_CLS__D3_CLS,
-	MX31_PIN_LCS0__GPI03_23,
+	MX31_PIN_LCS0__GPIO3_23,
 	/* CSI */
 	IOMUX_MODE(MX31_PIN_CSI_D5, IOMUX_CONFIG_GPIO),
 	MX31_PIN_CSI_D6__CSI_D6,
-- 
2.1.4
