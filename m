From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Tue, 07 Jan 2014 18:29:01 +0530
Subject: [PATCH V2 03/10] pinctrl: exynos: add exynos5260 SoC specific data
In-Reply-To: <1389099548-14649-1-git-send-email-rahul.sharma@samsung.com>
References: <1389099548-14649-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1389099548-14649-4-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Young-Gun Jang <yg1004.jang@samsung.com>

Add Samsung Exynos5260 SoC specific data to enable pinctrl
support for all platforms based on EXYNOS5260.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Young-Gun Jang <yg1004.jang@samsung.com>
Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
Signed-off-by: Arun Kumar K <arun.kk@samsung.com>
---
 .../bindings/pinctrl/samsung-pinctrl.txt           |    1 +
 drivers/pinctrl/pinctrl-exynos.c                   |   82 ++++++++++++++++++++
 drivers/pinctrl/pinctrl-samsung.c                  |    2 +
 drivers/pinctrl/pinctrl-samsung.h                  |    1 +
 4 files changed, 86 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
index 257677d..2b32783 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
@@ -16,6 +16,7 @@ Required Properties:
   - "samsung,exynos4210-pinctrl": for Exynos4210 compatible pin-controller.
   - "samsung,exynos4x12-pinctrl": for Exynos4x12 compatible pin-controller.
   - "samsung,exynos5250-pinctrl": for Exynos5250 compatible pin-controller.
+  - "samsung,exynos5260-pinctrl": for Exynos5260 compatible pin-controller.
   - "samsung,exynos5420-pinctrl": for Exynos5420 compatible pin-controller.
 
 - reg: Base address of the pin controller hardware module and length of
diff --git a/drivers/pinctrl/pinctrl-exynos.c b/drivers/pinctrl/pinctrl-exynos.c
index 155b1b3..07c8130 100644
--- a/drivers/pinctrl/pinctrl-exynos.c
+++ b/drivers/pinctrl/pinctrl-exynos.c
@@ -1042,6 +1042,88 @@ struct samsung_pin_ctrl exynos5250_pin_ctrl[] = {
 	},
 };
 
+/* pin banks of exynos5260 pin-controller 0 */
+static struct samsung_pin_bank exynos5260_pin_banks0[] = {
+	EXYNOS_PIN_BANK_EINTG(4, 0x000, "gpa0", 0x00),
+	EXYNOS_PIN_BANK_EINTG(7, 0x020, "gpa1", 0x04),
+	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpa2", 0x08),
+	EXYNOS_PIN_BANK_EINTG(5, 0x060, "gpb0", 0x0c),
+	EXYNOS_PIN_BANK_EINTG(4, 0x080, "gpb1", 0x10),
+	EXYNOS_PIN_BANK_EINTG(5, 0x0a0, "gpb2", 0x14),
+	EXYNOS_PIN_BANK_EINTG(8, 0x0c0, "gpb3", 0x18),
+	EXYNOS_PIN_BANK_EINTG(8, 0x0e0, "gpb4", 0x1c),
+	EXYNOS_PIN_BANK_EINTG(8, 0x100, "gpb5", 0x20),
+	EXYNOS_PIN_BANK_EINTG(8, 0x120, "gpd0", 0x24),
+	EXYNOS_PIN_BANK_EINTG(7, 0x140, "gpd1", 0x28),
+	EXYNOS_PIN_BANK_EINTG(5, 0x160, "gpd2", 0x2c),
+	EXYNOS_PIN_BANK_EINTG(8, 0x180, "gpe0", 0x30),
+	EXYNOS_PIN_BANK_EINTG(5, 0x1a0, "gpe1", 0x34),
+	EXYNOS_PIN_BANK_EINTG(4, 0x1c0, "gpf0", 0x38),
+	EXYNOS_PIN_BANK_EINTG(8, 0x1e0, "gpf1", 0x3c),
+	EXYNOS_PIN_BANK_EINTG(2, 0x200, "gpk0", 0x40),
+	EXYNOS_PIN_BANK_EINTW(8, 0xc00, "gpx0", 0x00),
+	EXYNOS_PIN_BANK_EINTW(8, 0xc20, "gpx1", 0x04),
+	EXYNOS_PIN_BANK_EINTW(8, 0xc40, "gpx2", 0x08),
+	EXYNOS_PIN_BANK_EINTW(8, 0xc60, "gpx3", 0x0c),
+};
+
+/* pin banks of exynos5260 pin-controller 1 */
+static struct samsung_pin_bank exynos5260_pin_banks1[] = {
+	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpc0", 0x00),
+	EXYNOS_PIN_BANK_EINTG(6, 0x020, "gpc1", 0x04),
+	EXYNOS_PIN_BANK_EINTG(7, 0x040, "gpc2", 0x08),
+	EXYNOS_PIN_BANK_EINTG(4, 0x060, "gpc3", 0x0c),
+	EXYNOS_PIN_BANK_EINTG(4, 0x080, "gpc4", 0x10),
+};
+
+/* pin banks of exynos5260 pin-controller 2 */
+static struct samsung_pin_bank exynos5260_pin_banks2[] = {
+	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz0", 0x00),
+	EXYNOS_PIN_BANK_EINTG(4, 0x020, "gpz1", 0x04),
+};
+
+/*
+ * Samsung pinctrl driver data for Exynos5260 SoC. Exynos5260 SoC includes
+ * three gpio/pin-mux/pinconfig controllers.
+ */
+struct samsung_pin_ctrl exynos5260_pin_ctrl[] = {
+	{
+		/* pin-controller instance 0 data */
+		.pin_banks	= exynos5260_pin_banks0,
+		.nr_banks	= ARRAY_SIZE(exynos5260_pin_banks0),
+		.geint_con	= EXYNOS_GPIO_ECON_OFFSET,
+		.geint_mask	= EXYNOS_GPIO_EMASK_OFFSET,
+		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
+		.weint_con	= EXYNOS_WKUP_ECON_OFFSET,
+		.weint_mask	= EXYNOS_WKUP_EMASK_OFFSET,
+		.weint_pend	= EXYNOS_WKUP_EPEND_OFFSET,
+		.svc		= EXYNOS_SVC_OFFSET,
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.eint_wkup_init = exynos_eint_wkup_init,
+		.label		= "exynos5260-gpio-ctrl0",
+	}, {
+		/* pin-controller instance 1 data */
+		.pin_banks	= exynos5260_pin_banks1,
+		.nr_banks	= ARRAY_SIZE(exynos5260_pin_banks1),
+		.geint_con	= EXYNOS_GPIO_ECON_OFFSET,
+		.geint_mask	= EXYNOS_GPIO_EMASK_OFFSET,
+		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
+		.svc		= EXYNOS_SVC_OFFSET,
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.label		= "exynos5260-gpio-ctrl1",
+	}, {
+		/* pin-controller instance 2 data */
+		.pin_banks	= exynos5260_pin_banks2,
+		.nr_banks	= ARRAY_SIZE(exynos5260_pin_banks2),
+		.geint_con	= EXYNOS_GPIO_ECON_OFFSET,
+		.geint_mask	= EXYNOS_GPIO_EMASK_OFFSET,
+		.geint_pend	= EXYNOS_GPIO_EPEND_OFFSET,
+		.svc		= EXYNOS_SVC_OFFSET,
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.label		= "exynos5260-gpio-ctrl2",
+	},
+};
+
 /* pin banks of exynos5420 pin-controller 0 */
 static struct samsung_pin_bank exynos5420_pin_banks0[] = {
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpy7", 0x00),
diff --git a/drivers/pinctrl/pinctrl-samsung.c b/drivers/pinctrl/pinctrl-samsung.c
index 47ec2e8..0324d4c 100644
--- a/drivers/pinctrl/pinctrl-samsung.c
+++ b/drivers/pinctrl/pinctrl-samsung.c
@@ -1120,6 +1120,8 @@ static const struct of_device_id samsung_pinctrl_dt_match[] = {
 		.data = (void *)exynos4x12_pin_ctrl },
 	{ .compatible = "samsung,exynos5250-pinctrl",
 		.data = (void *)exynos5250_pin_ctrl },
+	{ .compatible = "samsung,exynos5260-pinctrl",
+		.data = (void *)exynos5260_pin_ctrl },
 	{ .compatible = "samsung,exynos5420-pinctrl",
 		.data = (void *)exynos5420_pin_ctrl },
 	{ .compatible = "samsung,s5pv210-pinctrl",
diff --git a/drivers/pinctrl/pinctrl-samsung.h b/drivers/pinctrl/pinctrl-samsung.h
index 30622d9..bab9c21 100644
--- a/drivers/pinctrl/pinctrl-samsung.h
+++ b/drivers/pinctrl/pinctrl-samsung.h
@@ -254,6 +254,7 @@ struct samsung_pmx_func {
 extern struct samsung_pin_ctrl exynos4210_pin_ctrl[];
 extern struct samsung_pin_ctrl exynos4x12_pin_ctrl[];
 extern struct samsung_pin_ctrl exynos5250_pin_ctrl[];
+extern struct samsung_pin_ctrl exynos5260_pin_ctrl[];
 extern struct samsung_pin_ctrl exynos5420_pin_ctrl[];
 extern struct samsung_pin_ctrl s3c64xx_pin_ctrl[];
 extern struct samsung_pin_ctrl s3c2412_pin_ctrl[];
-- 
1.7.9.5
