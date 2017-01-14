From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 14 Jan 2017 14:36:41 +0200
Subject: [PATCH 3/4] pinctrl: samsung: Remove support for Exynos4415 (SoC not
 supported anymore)
In-Reply-To: <20170114123642.15581-1-krzk@kernel.org>
References: <20170114123642.15581-1-krzk@kernel.org>
Message-ID: <20170114123642.15581-4-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support for Exynos4415 is going away because there are no internal nor
external users.

Since commit 46dcf0ff0de3 ("ARM: dts: exynos: Remove exynos4415.dtsi"),
the platform cannot be instantiated so remove also the drivers.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/pinctrl/samsung/pinctrl-exynos.c  | 75 -------------------------------
 drivers/pinctrl/samsung/pinctrl-samsung.c |  2 -
 drivers/pinctrl/samsung/pinctrl-samsung.h |  1 -
 3 files changed, 78 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 07409fde02b2..24814db251a7 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -919,81 +919,6 @@ const struct samsung_pin_ctrl exynos4x12_pin_ctrl[] __initconst = {
 	},
 };
 
-/* pin banks of exynos4415 pin-controller 0 */
-static const struct samsung_pin_bank_data exynos4415_pin_banks0[] = {
-	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
-	EXYNOS_PIN_BANK_EINTG(6, 0x020, "gpa1", 0x04),
-	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpb", 0x08),
-	EXYNOS_PIN_BANK_EINTG(5, 0x060, "gpc0", 0x0c),
-	EXYNOS_PIN_BANK_EINTG(5, 0x080, "gpc1", 0x10),
-	EXYNOS_PIN_BANK_EINTG(4, 0x0A0, "gpd0", 0x14),
-	EXYNOS_PIN_BANK_EINTG(4, 0x0C0, "gpd1", 0x18),
-	EXYNOS_PIN_BANK_EINTG(8, 0x180, "gpf0", 0x30),
-	EXYNOS_PIN_BANK_EINTG(8, 0x1A0, "gpf1", 0x34),
-	EXYNOS_PIN_BANK_EINTG(1, 0x1C0, "gpf2", 0x38),
-};
-
-/* pin banks of exynos4415 pin-controller 1 */
-static const struct samsung_pin_bank_data exynos4415_pin_banks1[] = {
-	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpk0", 0x08),
-	EXYNOS_PIN_BANK_EINTG(7, 0x060, "gpk1", 0x0c),
-	EXYNOS_PIN_BANK_EINTG(7, 0x080, "gpk2", 0x10),
-	EXYNOS_PIN_BANK_EINTG(7, 0x0A0, "gpk3", 0x14),
-	EXYNOS_PIN_BANK_EINTG(4, 0x0C0, "gpl0", 0x18),
-	EXYNOS_PIN_BANK_EINTN(6, 0x120, "mp00"),
-	EXYNOS_PIN_BANK_EINTN(4, 0x140, "mp01"),
-	EXYNOS_PIN_BANK_EINTN(6, 0x160, "mp02"),
-	EXYNOS_PIN_BANK_EINTN(8, 0x180, "mp03"),
-	EXYNOS_PIN_BANK_EINTN(8, 0x1A0, "mp04"),
-	EXYNOS_PIN_BANK_EINTN(8, 0x1C0, "mp05"),
-	EXYNOS_PIN_BANK_EINTN(8, 0x1E0, "mp06"),
-	EXYNOS_PIN_BANK_EINTG(8, 0x260, "gpm0", 0x24),
-	EXYNOS_PIN_BANK_EINTG(7, 0x280, "gpm1", 0x28),
-	EXYNOS_PIN_BANK_EINTG(5, 0x2A0, "gpm2", 0x2c),
-	EXYNOS_PIN_BANK_EINTG(8, 0x2C0, "gpm3", 0x30),
-	EXYNOS_PIN_BANK_EINTG(8, 0x2E0, "gpm4", 0x34),
-	EXYNOS_PIN_BANK_EINTW(8, 0xC00, "gpx0", 0x00),
-	EXYNOS_PIN_BANK_EINTW(8, 0xC20, "gpx1", 0x04),
-	EXYNOS_PIN_BANK_EINTW(8, 0xC40, "gpx2", 0x08),
-	EXYNOS_PIN_BANK_EINTW(8, 0xC60, "gpx3", 0x0c),
-};
-
-/* pin banks of exynos4415 pin-controller 2 */
-static const struct samsung_pin_bank_data exynos4415_pin_banks2[] = {
-	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz", 0x00),
-	EXYNOS_PIN_BANK_EINTN(2, 0x000, "etc1"),
-};
-
-/*
- * Samsung pinctrl driver data for Exynos4415 SoC. Exynos4415 SoC includes
- * three gpio/pin-mux/pinconfig controllers.
- */
-const struct samsung_pin_ctrl exynos4415_pin_ctrl[] = {
-	{
-		/* pin-controller instance 0 data */
-		.pin_banks	= exynos4415_pin_banks0,
-		.nr_banks	= ARRAY_SIZE(exynos4415_pin_banks0),
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
-	}, {
-		/* pin-controller instance 1 data */
-		.pin_banks	= exynos4415_pin_banks1,
-		.nr_banks	= ARRAY_SIZE(exynos4415_pin_banks1),
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.eint_wkup_init = exynos_eint_wkup_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
-	}, {
-		/* pin-controller instance 2 data */
-		.pin_banks	= exynos4415_pin_banks2,
-		.nr_banks	= ARRAY_SIZE(exynos4415_pin_banks2),
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
-	},
-};
-
 /* pin banks of exynos5250 pin-controller 0 */
 static const struct samsung_pin_bank_data exynos5250_pin_banks0[] __initconst = {
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index 41e62391c33c..3bc925f61b71 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -1238,8 +1238,6 @@ static const struct of_device_id samsung_pinctrl_dt_match[] = {
 		.data = (void *)exynos4210_pin_ctrl },
 	{ .compatible = "samsung,exynos4x12-pinctrl",
 		.data = (void *)exynos4x12_pin_ctrl },
-	{ .compatible = "samsung,exynos4415-pinctrl",
-		.data = (void *)exynos4415_pin_ctrl },
 	{ .compatible = "samsung,exynos5250-pinctrl",
 		.data = (void *)exynos5250_pin_ctrl },
 	{ .compatible = "samsung,exynos5260-pinctrl",
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
index 043cb6c11180..6f7ce7539a00 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.h
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
@@ -273,7 +273,6 @@ struct samsung_pmx_func {
 extern const struct samsung_pin_ctrl exynos3250_pin_ctrl[];
 extern const struct samsung_pin_ctrl exynos4210_pin_ctrl[];
 extern const struct samsung_pin_ctrl exynos4x12_pin_ctrl[];
-extern const struct samsung_pin_ctrl exynos4415_pin_ctrl[];
 extern const struct samsung_pin_ctrl exynos5250_pin_ctrl[];
 extern const struct samsung_pin_ctrl exynos5260_pin_ctrl[];
 extern const struct samsung_pin_ctrl exynos5410_pin_ctrl[];
-- 
2.9.3
