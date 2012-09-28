From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 28 Sep 2012 16:28:35 +0200
Subject: [RFC PATCH 04/16] pinctrl: exynos: Remove static platform-specific
 data
In-Reply-To: <1348842527-22460-1-git-send-email-t.figa@samsung.com>
References: <1348842527-22460-1-git-send-email-t.figa@samsung.com>
Message-ID: <1348842527-22460-5-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch "pinctrl: samsung: Parse pin banks from DT" introduced parsing
platform-specific data from device tree, so there is no need to keep the
previously used definitions in headers and source files.

This patch cleans up the pinctrl-exynos driver from unused
platform-specific data.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 drivers/pinctrl/pinctrl-exynos.c  |  96 -----------------------
 drivers/pinctrl/pinctrl-exynos.h  | 157 --------------------------------------
 drivers/pinctrl/pinctrl-samsung.h |   1 -
 3 files changed, 254 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-exynos.c b/drivers/pinctrl/pinctrl-exynos.c
index e3fa263..134fecf 100644
--- a/drivers/pinctrl/pinctrl-exynos.c
+++ b/drivers/pinctrl/pinctrl-exynos.c
@@ -504,102 +504,6 @@ static int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
 	return 0;
 }
 
-/* pin banks of exynos4210 pin-controller 0 */
-static struct samsung_pin_bank exynos4210_pin_banks0[] = {
-	EXYNOS_PIN_BANK_EINTG(0x000, EXYNOS4210_GPIO_A0, "gpa0"),
-	EXYNOS_PIN_BANK_EINTG(0x020, EXYNOS4210_GPIO_A1, "gpa1"),
-	EXYNOS_PIN_BANK_EINTG(0x040, EXYNOS4210_GPIO_B, "gpb"),
-	EXYNOS_PIN_BANK_EINTG(0x060, EXYNOS4210_GPIO_C0, "gpc0"),
-	EXYNOS_PIN_BANK_EINTG(0x080, EXYNOS4210_GPIO_C1, "gpc1"),
-	EXYNOS_PIN_BANK_EINTG(0x0A0, EXYNOS4210_GPIO_D0, "gpd0"),
-	EXYNOS_PIN_BANK_EINTG(0x0C0, EXYNOS4210_GPIO_D1, "gpd1"),
-	EXYNOS_PIN_BANK_EINTG(0x0E0, EXYNOS4210_GPIO_E0, "gpe0"),
-	EXYNOS_PIN_BANK_EINTG(0x100, EXYNOS4210_GPIO_E1, "gpe1"),
-	EXYNOS_PIN_BANK_EINTG(0x120, EXYNOS4210_GPIO_E2, "gpe2"),
-	EXYNOS_PIN_BANK_EINTG(0x140, EXYNOS4210_GPIO_E3, "gpe3"),
-	EXYNOS_PIN_BANK_EINTG(0x160, EXYNOS4210_GPIO_E4, "gpe4"),
-	EXYNOS_PIN_BANK_EINTG(0x180, EXYNOS4210_GPIO_F0, "gpf0"),
-	EXYNOS_PIN_BANK_EINTG(0x1A0, EXYNOS4210_GPIO_F1, "gpf1"),
-	EXYNOS_PIN_BANK_EINTG(0x1C0, EXYNOS4210_GPIO_F2, "gpf2"),
-	EXYNOS_PIN_BANK_EINTG(0x1E0, EXYNOS4210_GPIO_F3, "gpf3"),
-};
-
-/* pin banks of exynos4210 pin-controller 1 */
-static struct samsung_pin_bank exynos4210_pin_banks1[] = {
-	EXYNOS_PIN_BANK_EINTG(0x000, EXYNOS4210_GPIO_J0, "gpj0"),
-	EXYNOS_PIN_BANK_EINTG(0x020, EXYNOS4210_GPIO_J1, "gpj1"),
-	EXYNOS_PIN_BANK_EINTG(0x040, EXYNOS4210_GPIO_K0, "gpk0"),
-	EXYNOS_PIN_BANK_EINTG(0x060, EXYNOS4210_GPIO_K1, "gpk1"),
-	EXYNOS_PIN_BANK_EINTG(0x080, EXYNOS4210_GPIO_K2, "gpk2"),
-	EXYNOS_PIN_BANK_EINTG(0x0A0, EXYNOS4210_GPIO_K3, "gpk3"),
-	EXYNOS_PIN_BANK_EINTG(0x0C0, EXYNOS4210_GPIO_L0, "gpl0"),
-	EXYNOS_PIN_BANK_EINTG(0x0E0, EXYNOS4210_GPIO_L1, "gpl1"),
-	EXYNOS_PIN_BANK_EINTG(0x100, EXYNOS4210_GPIO_L2, "gpl2"),
-	EXYNOS_PIN_BANK_EINTN(0x120, EXYNOS4210_GPIO_Y0, "gpy0"),
-	EXYNOS_PIN_BANK_EINTN(0x140, EXYNOS4210_GPIO_Y1, "gpy1"),
-	EXYNOS_PIN_BANK_EINTN(0x160, EXYNOS4210_GPIO_Y2, "gpy2"),
-	EXYNOS_PIN_BANK_EINTN(0x180, EXYNOS4210_GPIO_Y3, "gpy3"),
-	EXYNOS_PIN_BANK_EINTN(0x1A0, EXYNOS4210_GPIO_Y4, "gpy4"),
-	EXYNOS_PIN_BANK_EINTN(0x1C0, EXYNOS4210_GPIO_Y5, "gpy5"),
-	EXYNOS_PIN_BANK_EINTN(0x1E0, EXYNOS4210_GPIO_Y6, "gpy6"),
-	EXYNOS_PIN_BANK_EINTN(0xC00, EXYNOS4210_GPIO_X0, "gpx0"),
-	EXYNOS_PIN_BANK_EINTN(0xC20, EXYNOS4210_GPIO_X1, "gpx1"),
-	EXYNOS_PIN_BANK_EINTN(0xC40, EXYNOS4210_GPIO_X2, "gpx2"),
-	EXYNOS_PIN_BANK_EINTN(0xC60, EXYNOS4210_GPIO_X3, "gpx3"),
-};
-
-/* pin banks of exynos4210 pin-controller 2 */
-static struct samsung_pin_bank exynos4210_pin_banks2[] = {
-	EXYNOS_PIN_BANK_EINTN(0x000, EXYNOS4210_GPIO_Z, "gpz"),
-};
-
-/*
- * Samsung pinctrl driver data for Exynos4210 SoC. Exynos4210 SoC includes
- * three gpio/pin-mux/pinconfig controllers.
- */
-struct samsung_pin_ctrl exynos4210_pin_ctrl[] = {
-	{
-		/* pin-controller instance 0 data */
-		.pin_banks	= exynos4210_pin_banks0,
-		.nr_banks	= ARRAY_SIZE(exynos4210_pin_banks0),
-		.base		= EXYNOS4210_GPIO_A0_START,
-		.nr_pins	= EXYNOS4210_GPIOA_NR_PINS,
-		.nr_gint	= EXYNOS4210_GPIOA_NR_GINT,
-		.geint_con	= EXYNOS_GPIO_ECON_OFFSET,
-		.geint_mask	= EXYNOS_GPIO_EMASK_OFFSET,
-		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
-		.svc		= EXYNOS_SVC_OFFSET,
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.label		= "exynos4210-gpio-ctrl0",
-	}, {
-		/* pin-controller instance 1 data */
-		.pin_banks	= exynos4210_pin_banks1,
-		.nr_banks	= ARRAY_SIZE(exynos4210_pin_banks1),
-		.base		= EXYNOS4210_GPIOA_NR_PINS,
-		.nr_pins	= EXYNOS4210_GPIOB_NR_PINS,
-		.nr_gint	= EXYNOS4210_GPIOB_NR_GINT,
-		.nr_wint	= 32,
-		.geint_con	= EXYNOS_GPIO_ECON_OFFSET,
-		.geint_mask	= EXYNOS_GPIO_EMASK_OFFSET,
-		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
-		.weint_con	= EXYNOS_WKUP_ECON_OFFSET,
-		.weint_mask	= EXYNOS_WKUP_EMASK_OFFSET,
-		.weint_pend	= EXYNOS_WKUP_EPEND_OFFSET,
-		.svc		= EXYNOS_SVC_OFFSET,
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.eint_wkup_init = exynos_eint_wkup_init,
-		.label		= "exynos4210-gpio-ctrl1",
-	}, {
-		/* pin-controller instance 2 data */
-		.pin_banks	= exynos4210_pin_banks2,
-		.nr_banks	= ARRAY_SIZE(exynos4210_pin_banks2),
-		.base		= EXYNOS4210_GPIOA_NR_PINS +
-					EXYNOS4210_GPIOB_NR_PINS,
-		.nr_pins	= EXYNOS4210_GPIOC_NR_PINS,
-		.label		= "exynos4210-gpio-ctrl2",
-	},
-};
-
 struct samsung_pin_ctrl_variant exynos4_pin_ctrl = {
 	.eint_gpio_init = exynos_eint_gpio_init,
 	.eint_wkup_init = exynos_eint_wkup_init,
diff --git a/drivers/pinctrl/pinctrl-exynos.h b/drivers/pinctrl/pinctrl-exynos.h
index 31d0a06..a72cfc7 100644
--- a/drivers/pinctrl/pinctrl-exynos.h
+++ b/drivers/pinctrl/pinctrl-exynos.h
@@ -17,133 +17,6 @@
  * (at your option) any later version.
  */
 
-#define EXYNOS_GPIO_START(__gpio)	((__gpio##_START) + (__gpio##_NR))
-
-#define EXYNOS4210_GPIO_A0_NR	(8)
-#define EXYNOS4210_GPIO_A1_NR	(6)
-#define EXYNOS4210_GPIO_B_NR	(8)
-#define EXYNOS4210_GPIO_C0_NR	(5)
-#define EXYNOS4210_GPIO_C1_NR	(5)
-#define EXYNOS4210_GPIO_D0_NR	(4)
-#define EXYNOS4210_GPIO_D1_NR	(4)
-#define EXYNOS4210_GPIO_E0_NR	(5)
-#define EXYNOS4210_GPIO_E1_NR	(8)
-#define EXYNOS4210_GPIO_E2_NR	(6)
-#define EXYNOS4210_GPIO_E3_NR	(8)
-#define EXYNOS4210_GPIO_E4_NR	(8)
-#define EXYNOS4210_GPIO_F0_NR	(8)
-#define EXYNOS4210_GPIO_F1_NR	(8)
-#define EXYNOS4210_GPIO_F2_NR	(8)
-#define EXYNOS4210_GPIO_F3_NR	(6)
-#define EXYNOS4210_GPIO_J0_NR	(8)
-#define EXYNOS4210_GPIO_J1_NR	(5)
-#define EXYNOS4210_GPIO_K0_NR	(7)
-#define EXYNOS4210_GPIO_K1_NR	(7)
-#define EXYNOS4210_GPIO_K2_NR	(7)
-#define EXYNOS4210_GPIO_K3_NR	(7)
-#define EXYNOS4210_GPIO_L0_NR	(8)
-#define EXYNOS4210_GPIO_L1_NR	(3)
-#define EXYNOS4210_GPIO_L2_NR	(8)
-#define EXYNOS4210_GPIO_Y0_NR	(6)
-#define EXYNOS4210_GPIO_Y1_NR	(4)
-#define EXYNOS4210_GPIO_Y2_NR	(6)
-#define EXYNOS4210_GPIO_Y3_NR	(8)
-#define EXYNOS4210_GPIO_Y4_NR	(8)
-#define EXYNOS4210_GPIO_Y5_NR	(8)
-#define EXYNOS4210_GPIO_Y6_NR	(8)
-#define EXYNOS4210_GPIO_X0_NR	(8)
-#define EXYNOS4210_GPIO_X1_NR	(8)
-#define EXYNOS4210_GPIO_X2_NR	(8)
-#define EXYNOS4210_GPIO_X3_NR	(8)
-#define EXYNOS4210_GPIO_Z_NR	(7)
-
-enum exynos4210_gpio_xa_start {
-	EXYNOS4210_GPIO_A0_START	= 0,
-	EXYNOS4210_GPIO_A1_START	= EXYNOS_GPIO_START(EXYNOS4210_GPIO_A0),
-	EXYNOS4210_GPIO_B_START		= EXYNOS_GPIO_START(EXYNOS4210_GPIO_A1),
-	EXYNOS4210_GPIO_C0_START	= EXYNOS_GPIO_START(EXYNOS4210_GPIO_B),
-	EXYNOS4210_GPIO_C1_START	= EXYNOS_GPIO_START(EXYNOS4210_GPIO_C0),
-	EXYNOS4210_GPIO_D0_START	= EXYNOS_GPIO_START(EXYNOS4210_GPIO_C1),
-	EXYNOS4210_GPIO_D1_START	= EXYNOS_GPIO_START(EXYNOS4210_GPIO_D0),
-	EXYNOS4210_GPIO_E0_START	= EXYNOS_GPIO_START(EXYNOS4210_GPIO_D1),
-	EXYNOS4210_GPIO_E1_START	= EXYNOS_GPIO_START(EXYNOS4210_GPIO_E0),
-	EXYNOS4210_GPIO_E2_START	= EXYNOS_GPIO_START(EXYNOS4210_GPIO_E1),
-	EXYNOS4210_GPIO_E3_START	= EXYNOS_GPIO_START(EXYNOS4210_GPIO_E2),
-	EXYNOS4210_GPIO_E4_START	= EXYNOS_GPIO_START(EXYNOS4210_GPIO_E3),
-	EXYNOS4210_GPIO_F0_START	= EXYNOS_GPIO_START(EXYNOS4210_GPIO_E4),
-	EXYNOS4210_GPIO_F1_START	= EXYNOS_GPIO_START(EXYNOS4210_GPIO_F0),
-	EXYNOS4210_GPIO_F2_START	= EXYNOS_GPIO_START(EXYNOS4210_GPIO_F1),
-	EXYNOS4210_GPIO_F3_START	= EXYNOS_GPIO_START(EXYNOS4210_GPIO_F2),
-};
-
-enum exynos4210_gpio_xb_start {
-	EXYNOS4210_GPIO_J0_START	= 0,
-	EXYNOS4210_GPIO_J1_START	= EXYNOS_GPIO_START(EXYNOS4210_GPIO_J0),
-	EXYNOS4210_GPIO_K0_START	= EXYNOS_GPIO_START(EXYNOS4210_GPIO_J1),
-	EXYNOS4210_GPIO_K1_START	= EXYNOS_GPIO_START(EXYNOS4210_GPIO_K0),
-	EXYNOS4210_GPIO_K2_START	= EXYNOS_GPIO_START(EXYNOS4210_GPIO_K1),
-	EXYNOS4210_GPIO_K3_START	= EXYNOS_GPIO_START(EXYNOS4210_GPIO_K2),
-	EXYNOS4210_GPIO_L0_START	= EXYNOS_GPIO_START(EXYNOS4210_GPIO_K3),
-	EXYNOS4210_GPIO_L1_START	= EXYNOS_GPIO_START(EXYNOS4210_GPIO_L0),
-	EXYNOS4210_GPIO_L2_START	= EXYNOS_GPIO_START(EXYNOS4210_GPIO_L1),
-	EXYNOS4210_GPIO_Y0_START	= EXYNOS_GPIO_START(EXYNOS4210_GPIO_L2),
-	EXYNOS4210_GPIO_Y1_START	= EXYNOS_GPIO_START(EXYNOS4210_GPIO_Y0),
-	EXYNOS4210_GPIO_Y2_START	= EXYNOS_GPIO_START(EXYNOS4210_GPIO_Y1),
-	EXYNOS4210_GPIO_Y3_START	= EXYNOS_GPIO_START(EXYNOS4210_GPIO_Y2),
-	EXYNOS4210_GPIO_Y4_START	= EXYNOS_GPIO_START(EXYNOS4210_GPIO_Y3),
-	EXYNOS4210_GPIO_Y5_START	= EXYNOS_GPIO_START(EXYNOS4210_GPIO_Y4),
-	EXYNOS4210_GPIO_Y6_START	= EXYNOS_GPIO_START(EXYNOS4210_GPIO_Y5),
-	EXYNOS4210_GPIO_X0_START	= EXYNOS_GPIO_START(EXYNOS4210_GPIO_Y6),
-	EXYNOS4210_GPIO_X1_START	= EXYNOS_GPIO_START(EXYNOS4210_GPIO_X0),
-	EXYNOS4210_GPIO_X2_START	= EXYNOS_GPIO_START(EXYNOS4210_GPIO_X1),
-	EXYNOS4210_GPIO_X3_START	= EXYNOS_GPIO_START(EXYNOS4210_GPIO_X2),
-};
-
-enum exynos4210_gpio_xc_start {
-	EXYNOS4210_GPIO_Z_START		= 0,
-};
-
-#define	EXYNOS4210_GPIO_A0_IRQ		EXYNOS4210_GPIO_A0_START
-#define	EXYNOS4210_GPIO_A1_IRQ		EXYNOS4210_GPIO_A1_START
-#define	EXYNOS4210_GPIO_B_IRQ		EXYNOS4210_GPIO_B_START
-#define	EXYNOS4210_GPIO_C0_IRQ		EXYNOS4210_GPIO_C0_START
-#define	EXYNOS4210_GPIO_C1_IRQ		EXYNOS4210_GPIO_C1_START
-#define	EXYNOS4210_GPIO_D0_IRQ		EXYNOS4210_GPIO_D0_START
-#define	EXYNOS4210_GPIO_D1_IRQ		EXYNOS4210_GPIO_D1_START
-#define	EXYNOS4210_GPIO_E0_IRQ		EXYNOS4210_GPIO_E0_START
-#define	EXYNOS4210_GPIO_E1_IRQ		EXYNOS4210_GPIO_E1_START
-#define	EXYNOS4210_GPIO_E2_IRQ		EXYNOS4210_GPIO_E2_START
-#define	EXYNOS4210_GPIO_E3_IRQ		EXYNOS4210_GPIO_E3_START
-#define	EXYNOS4210_GPIO_E4_IRQ		EXYNOS4210_GPIO_E4_START
-#define	EXYNOS4210_GPIO_F0_IRQ		EXYNOS4210_GPIO_F0_START
-#define	EXYNOS4210_GPIO_F1_IRQ		EXYNOS4210_GPIO_F1_START
-#define	EXYNOS4210_GPIO_F2_IRQ		EXYNOS4210_GPIO_F2_START
-#define	EXYNOS4210_GPIO_F3_IRQ		EXYNOS4210_GPIO_F3_START
-#define	EXYNOS4210_GPIO_J0_IRQ		EXYNOS4210_GPIO_J0_START
-#define	EXYNOS4210_GPIO_J1_IRQ		EXYNOS4210_GPIO_J1_START
-#define	EXYNOS4210_GPIO_K0_IRQ		EXYNOS4210_GPIO_K0_START
-#define	EXYNOS4210_GPIO_K1_IRQ		EXYNOS4210_GPIO_K1_START
-#define	EXYNOS4210_GPIO_K2_IRQ		EXYNOS4210_GPIO_K2_START
-#define	EXYNOS4210_GPIO_K3_IRQ		EXYNOS4210_GPIO_K3_START
-#define	EXYNOS4210_GPIO_L0_IRQ		EXYNOS4210_GPIO_L0_START
-#define	EXYNOS4210_GPIO_L1_IRQ		EXYNOS4210_GPIO_L1_START
-#define	EXYNOS4210_GPIO_L2_IRQ		EXYNOS4210_GPIO_L2_START
-#define	EXYNOS4210_GPIO_Z_IRQ		EXYNOS4210_GPIO_Z_START
-
-#define EXYNOS4210_GPIOA_NR_PINS	EXYNOS_GPIO_START(EXYNOS4210_GPIO_F3)
-#define EXYNOS4210_GPIOA_NR_GINT	EXYNOS_GPIO_START(EXYNOS4210_GPIO_F3)
-#define EXYNOS4210_GPIOB_NR_PINS	EXYNOS_GPIO_START(EXYNOS4210_GPIO_X3)
-#define EXYNOS4210_GPIOB_NR_GINT	EXYNOS_GPIO_START(EXYNOS4210_GPIO_L2)
-#define EXYNOS4210_GPIOC_NR_PINS	EXYNOS_GPIO_START(EXYNOS4210_GPIO_Z)
-
-/* External GPIO and wakeup interrupt related definitions */
-#define EXYNOS_GPIO_ECON_OFFSET		0x700
-#define EXYNOS_GPIO_EMASK_OFFSET	0x900
-#define EXYNOS_GPIO_EPEND_OFFSET	0xA00
-#define EXYNOS_WKUP_ECON_OFFSET		0xE00
-#define EXYNOS_WKUP_EMASK_OFFSET	0xF00
-#define EXYNOS_WKUP_EPEND_OFFSET	0xF40
-#define EXYNOS_SVC_OFFSET		0xB08
 #define EXYNOS_EINT_FUNC		0xF
 
 /* helpers to access interrupt service register */
@@ -163,36 +36,6 @@ enum exynos4210_gpio_xc_start {
 #define EXYNOS_EINT_CON_LEN		4
 
 #define EXYNOS_EINT_MAX_PER_BANK	8
-#define EXYNOS_EINT_NR_WKUP_EINT
-
-#define EXYNOS_PIN_BANK_EINTN(reg, __gpio, id)		\
-	{						\
-		.pctl_offset	= reg,			\
-		.pin_base	= (__gpio##_START),	\
-		.nr_pins	= (__gpio##_NR),	\
-		.func_width	= 4,			\
-		.pud_width	= 2,			\
-		.drv_width	= 2,			\
-		.conpdn_width	= 2,			\
-		.pudpdn_width	= 2,			\
-		.eint_type	= EINT_TYPE_NONE,	\
-		.name		= id			\
-	}
-
-#define EXYNOS_PIN_BANK_EINTG(reg, __gpio, id)		\
-	{						\
-		.pctl_offset	= reg,			\
-		.pin_base	= (__gpio##_START),	\
-		.nr_pins	= (__gpio##_NR),	\
-		.func_width	= 4,			\
-		.pud_width	= 2,			\
-		.drv_width	= 2,			\
-		.conpdn_width	= 2,			\
-		.pudpdn_width	= 2,			\
-		.eint_type	= EINT_TYPE_GPIO,	\
-		.irq_base	= (__gpio##_IRQ),	\
-		.name		= id			\
-	}
 
 /**
  * struct exynos_geint_data: gpio eint specific data for irq_chip callbacks.
diff --git a/drivers/pinctrl/pinctrl-samsung.h b/drivers/pinctrl/pinctrl-samsung.h
index 5d59ce6..db1907c 100644
--- a/drivers/pinctrl/pinctrl-samsung.h
+++ b/drivers/pinctrl/pinctrl-samsung.h
@@ -246,7 +246,6 @@ struct samsung_pmx_func {
 };
 
 /* list of all exported SoC specific data */
-extern struct samsung_pin_ctrl exynos4210_pin_ctrl[];
 extern struct samsung_pin_ctrl_variant exynos4_pin_ctrl;
 
 #endif /* __PINCTRL_SAMSUNG_H */
-- 
1.7.12
