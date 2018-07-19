From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 19 Jul 2018 18:00:41 +0200
Subject: [RFT 01/10] pinctrl: samsung: Define suspend and resume callbacks for
 all banks and SoCs
In-Reply-To: <20180719160050.22566-1-krzk@kernel.org>
References: <20180719160050.22566-1-krzk@kernel.org>
Message-ID: <20180719160050.22566-2-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend and resume callbacks in Exynos/S5Pv210 pin controller drivers,
save and restore state of registers.  This operations should be done for
all banks which have external interrupts (as denoted by using
EXYNOS_PIN_BANK_EINTG/EINTW macros).

Add all banks of Exynos5260 and Exynos5420.

This is necessary step for supporting suspend to RAM.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/pinctrl/samsung/pinctrl-exynos-arm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm.c b/drivers/pinctrl/samsung/pinctrl-exynos-arm.c
index d82820fc349a..44c6b753f692 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos-arm.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm.c
@@ -616,16 +616,22 @@ static const struct samsung_pin_ctrl exynos5260_pin_ctrl[] __initconst = {
 		.nr_banks	= ARRAY_SIZE(exynos5260_pin_banks0),
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.eint_wkup_init = exynos_eint_wkup_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
 	}, {
 		/* pin-controller instance 1 data */
 		.pin_banks	= exynos5260_pin_banks1,
 		.nr_banks	= ARRAY_SIZE(exynos5260_pin_banks1),
 		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
 	}, {
 		/* pin-controller instance 2 data */
 		.pin_banks	= exynos5260_pin_banks2,
 		.nr_banks	= ARRAY_SIZE(exynos5260_pin_banks2),
 		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
 	},
 };
 
@@ -842,30 +848,40 @@ static const struct samsung_pin_ctrl exynos5420_pin_ctrl[] __initconst = {
 		.nr_banks	= ARRAY_SIZE(exynos5420_pin_banks0),
 		.eint_gpio_init = exynos_eint_gpio_init,
 		.eint_wkup_init = exynos_eint_wkup_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
 		.retention_data	= &exynos5420_retention_data,
 	}, {
 		/* pin-controller instance 1 data */
 		.pin_banks	= exynos5420_pin_banks1,
 		.nr_banks	= ARRAY_SIZE(exynos5420_pin_banks1),
 		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
 		.retention_data	= &exynos5420_retention_data,
 	}, {
 		/* pin-controller instance 2 data */
 		.pin_banks	= exynos5420_pin_banks2,
 		.nr_banks	= ARRAY_SIZE(exynos5420_pin_banks2),
 		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
 		.retention_data	= &exynos5420_retention_data,
 	}, {
 		/* pin-controller instance 3 data */
 		.pin_banks	= exynos5420_pin_banks3,
 		.nr_banks	= ARRAY_SIZE(exynos5420_pin_banks3),
 		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
 		.retention_data	= &exynos5420_retention_data,
 	}, {
 		/* pin-controller instance 4 data */
 		.pin_banks	= exynos5420_pin_banks4,
 		.nr_banks	= ARRAY_SIZE(exynos5420_pin_banks4),
 		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
 		.retention_data	= &exynos4_audio_retention_data,
 	},
 };
-- 
2.14.1
