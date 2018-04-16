From: pawel.mikolaj.chmiel@gmail.com (=?UTF-8?q?Pawe=C5=82=20Chmiel?=)
Date: Mon, 16 Apr 2018 17:52:46 +0200
Subject: [PATCH v2 2/2] pinctrl/samsung: Document required order of banks
In-Reply-To: <1523893966-8884-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1523893966-8884-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Message-ID: <1523893966-8884-3-git-send-email-pawel.mikolaj.chmiel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch documents requirement coming from the way
exynos_eint_gpio_irq() is working now, which expects
EINTG banks to be at the beginning of the bank arrays.

Cc: stable at vger.kernel.org
Signed-off-by: Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/pinctrl/samsung/pinctrl-exynos-arm.c   | 26 ++++++++++++++++++++++++++
 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c | 20 ++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm.c b/drivers/pinctrl/samsung/pinctrl-exynos-arm.c
index 4f4ae66..d82820f 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos-arm.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm.c
@@ -88,6 +88,7 @@ static const struct samsung_retention_data s5pv210_retention_data __initconst =
 
 /* pin banks of s5pv210 pin-controller */
 static const struct samsung_pin_bank_data s5pv210_pin_bank[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(4, 0x020, "gpa1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpb", 0x08),
@@ -147,6 +148,7 @@ static atomic_t exynos_shared_retention_refcnt;
 
 /* pin banks of exynos3250 pin-controller 0 */
 static const struct samsung_pin_bank_data exynos3250_pin_banks0[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(6, 0x020, "gpa1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpb",  0x08),
@@ -158,6 +160,7 @@ static const struct samsung_pin_bank_data exynos3250_pin_banks0[] __initconst =
 
 /* pin banks of exynos3250 pin-controller 1 */
 static const struct samsung_pin_bank_data exynos3250_pin_banks1[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTN(8, 0x120, "gpe0"),
 	EXYNOS_PIN_BANK_EINTN(8, 0x140, "gpe1"),
 	EXYNOS_PIN_BANK_EINTN(3, 0x180, "gpe2"),
@@ -232,6 +235,7 @@ const struct samsung_pinctrl_of_match_data exynos3250_of_data __initconst = {
 
 /* pin banks of exynos4210 pin-controller 0 */
 static const struct samsung_pin_bank_data exynos4210_pin_banks0[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(6, 0x020, "gpa1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpb", 0x08),
@@ -252,6 +256,7 @@ static const struct samsung_pin_bank_data exynos4210_pin_banks0[] __initconst =
 
 /* pin banks of exynos4210 pin-controller 1 */
 static const struct samsung_pin_bank_data exynos4210_pin_banks1[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpj0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(5, 0x020, "gpj1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(7, 0x040, "gpk0", 0x08),
@@ -276,6 +281,7 @@ static const struct samsung_pin_bank_data exynos4210_pin_banks1[] __initconst =
 
 /* pin banks of exynos4210 pin-controller 2 */
 static const struct samsung_pin_bank_data exynos4210_pin_banks2[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTN(7, 0x000, "gpz"),
 };
 
@@ -346,6 +352,7 @@ const struct samsung_pinctrl_of_match_data exynos4210_of_data __initconst = {
 
 /* pin banks of exynos4x12 pin-controller 0 */
 static const struct samsung_pin_bank_data exynos4x12_pin_banks0[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(6, 0x020, "gpa1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpb", 0x08),
@@ -363,6 +370,7 @@ static const struct samsung_pin_bank_data exynos4x12_pin_banks0[] __initconst =
 
 /* pin banks of exynos4x12 pin-controller 1 */
 static const struct samsung_pin_bank_data exynos4x12_pin_banks1[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(7, 0x040, "gpk0", 0x08),
 	EXYNOS_PIN_BANK_EINTG(7, 0x060, "gpk1", 0x0c),
 	EXYNOS_PIN_BANK_EINTG(7, 0x080, "gpk2", 0x10),
@@ -390,11 +398,13 @@ static const struct samsung_pin_bank_data exynos4x12_pin_banks1[] __initconst =
 
 /* pin banks of exynos4x12 pin-controller 2 */
 static const struct samsung_pin_bank_data exynos4x12_pin_banks2[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz", 0x00),
 };
 
 /* pin banks of exynos4x12 pin-controller 3 */
 static const struct samsung_pin_bank_data exynos4x12_pin_banks3[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpv0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpv1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpv2", 0x08),
@@ -449,6 +459,7 @@ const struct samsung_pinctrl_of_match_data exynos4x12_of_data __initconst = {
 
 /* pin banks of exynos5250 pin-controller 0 */
 static const struct samsung_pin_bank_data exynos5250_pin_banks0[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(6, 0x020, "gpa1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpa2", 0x08),
@@ -478,6 +489,7 @@ static const struct samsung_pin_bank_data exynos5250_pin_banks0[] __initconst =
 
 /* pin banks of exynos5250 pin-controller 1 */
 static const struct samsung_pin_bank_data exynos5250_pin_banks1[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpe0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(2, 0x020, "gpe1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(4, 0x040, "gpf0", 0x08),
@@ -491,6 +503,7 @@ static const struct samsung_pin_bank_data exynos5250_pin_banks1[] __initconst =
 
 /* pin banks of exynos5250 pin-controller 2 */
 static const struct samsung_pin_bank_data exynos5250_pin_banks2[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpv0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpv1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(8, 0x060, "gpv2", 0x08),
@@ -500,6 +513,7 @@ static const struct samsung_pin_bank_data exynos5250_pin_banks2[] __initconst =
 
 /* pin banks of exynos5250 pin-controller 3 */
 static const struct samsung_pin_bank_data exynos5250_pin_banks3[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz", 0x00),
 };
 
@@ -550,6 +564,7 @@ const struct samsung_pinctrl_of_match_data exynos5250_of_data __initconst = {
 
 /* pin banks of exynos5260 pin-controller 0 */
 static const struct samsung_pin_bank_data exynos5260_pin_banks0[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(4, 0x000, "gpa0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(7, 0x020, "gpa1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpa2", 0x08),
@@ -575,6 +590,7 @@ static const struct samsung_pin_bank_data exynos5260_pin_banks0[] __initconst =
 
 /* pin banks of exynos5260 pin-controller 1 */
 static const struct samsung_pin_bank_data exynos5260_pin_banks1[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpc0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(6, 0x020, "gpc1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(7, 0x040, "gpc2", 0x08),
@@ -584,6 +600,7 @@ static const struct samsung_pin_bank_data exynos5260_pin_banks1[] __initconst =
 
 /* pin banks of exynos5260 pin-controller 2 */
 static const struct samsung_pin_bank_data exynos5260_pin_banks2[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(4, 0x020, "gpz1", 0x04),
 };
@@ -619,6 +636,7 @@ const struct samsung_pinctrl_of_match_data exynos5260_of_data __initconst = {
 
 /* pin banks of exynos5410 pin-controller 0 */
 static const struct samsung_pin_bank_data exynos5410_pin_banks0[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(6, 0x020, "gpa1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpa2", 0x08),
@@ -658,6 +676,7 @@ static const struct samsung_pin_bank_data exynos5410_pin_banks0[] __initconst =
 
 /* pin banks of exynos5410 pin-controller 1 */
 static const struct samsung_pin_bank_data exynos5410_pin_banks1[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(5, 0x000, "gpj0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpj1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpj2", 0x08),
@@ -671,6 +690,7 @@ static const struct samsung_pin_bank_data exynos5410_pin_banks1[] __initconst =
 
 /* pin banks of exynos5410 pin-controller 2 */
 static const struct samsung_pin_bank_data exynos5410_pin_banks2[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpv0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpv1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(8, 0x060, "gpv2", 0x08),
@@ -680,6 +700,7 @@ static const struct samsung_pin_bank_data exynos5410_pin_banks2[] __initconst =
 
 /* pin banks of exynos5410 pin-controller 3 */
 static const struct samsung_pin_bank_data exynos5410_pin_banks3[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz", 0x00),
 };
 
@@ -727,6 +748,7 @@ const struct samsung_pinctrl_of_match_data exynos5410_of_data __initconst = {
 
 /* pin banks of exynos5420 pin-controller 0 */
 static const struct samsung_pin_bank_data exynos5420_pin_banks0[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpy7", 0x00),
 	EXYNOS_PIN_BANK_EINTW(8, 0xC00, "gpx0", 0x00),
 	EXYNOS_PIN_BANK_EINTW(8, 0xC20, "gpx1", 0x04),
@@ -736,6 +758,7 @@ static const struct samsung_pin_bank_data exynos5420_pin_banks0[] __initconst =
 
 /* pin banks of exynos5420 pin-controller 1 */
 static const struct samsung_pin_bank_data exynos5420_pin_banks1[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpc0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpc1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(7, 0x040, "gpc2", 0x08),
@@ -753,6 +776,7 @@ static const struct samsung_pin_bank_data exynos5420_pin_banks1[] __initconst =
 
 /* pin banks of exynos5420 pin-controller 2 */
 static const struct samsung_pin_bank_data exynos5420_pin_banks2[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpe0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(2, 0x020, "gpe1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(6, 0x040, "gpf0", 0x08),
@@ -765,6 +789,7 @@ static const struct samsung_pin_bank_data exynos5420_pin_banks2[] __initconst =
 
 /* pin banks of exynos5420 pin-controller 3 */
 static const struct samsung_pin_bank_data exynos5420_pin_banks3[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(6, 0x020, "gpa1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpa2", 0x08),
@@ -778,6 +803,7 @@ static const struct samsung_pin_bank_data exynos5420_pin_banks3[] __initconst =
 
 /* pin banks of exynos5420 pin-controller 4 */
 static const struct samsung_pin_bank_data exynos5420_pin_banks4[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz", 0x00),
 };
 
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
index 71c9d1d..b6e5642 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
@@ -45,6 +45,7 @@ static atomic_t exynos_shared_retention_refcnt;
 
 /* pin banks of exynos5433 pin-controller - ALIVE */
 static const struct samsung_pin_bank_data exynos5433_pin_banks0[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS5433_PIN_BANK_EINTW(8, 0x000, "gpa0", 0x00),
 	EXYNOS5433_PIN_BANK_EINTW(8, 0x020, "gpa1", 0x04),
 	EXYNOS5433_PIN_BANK_EINTW(8, 0x040, "gpa2", 0x08),
@@ -58,27 +59,32 @@ static const struct samsung_pin_bank_data exynos5433_pin_banks0[] __initconst =
 
 /* pin banks of exynos5433 pin-controller - AUD */
 static const struct samsung_pin_bank_data exynos5433_pin_banks1[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS5433_PIN_BANK_EINTG(7, 0x000, "gpz0", 0x00),
 	EXYNOS5433_PIN_BANK_EINTG(4, 0x020, "gpz1", 0x04),
 };
 
 /* pin banks of exynos5433 pin-controller - CPIF */
 static const struct samsung_pin_bank_data exynos5433_pin_banks2[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS5433_PIN_BANK_EINTG(2, 0x000, "gpv6", 0x00),
 };
 
 /* pin banks of exynos5433 pin-controller - eSE */
 static const struct samsung_pin_bank_data exynos5433_pin_banks3[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS5433_PIN_BANK_EINTG(3, 0x000, "gpj2", 0x00),
 };
 
 /* pin banks of exynos5433 pin-controller - FINGER */
 static const struct samsung_pin_bank_data exynos5433_pin_banks4[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS5433_PIN_BANK_EINTG(4, 0x000, "gpd5", 0x00),
 };
 
 /* pin banks of exynos5433 pin-controller - FSYS */
 static const struct samsung_pin_bank_data exynos5433_pin_banks5[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS5433_PIN_BANK_EINTG(6, 0x000, "gph1", 0x00),
 	EXYNOS5433_PIN_BANK_EINTG(7, 0x020, "gpr4", 0x04),
 	EXYNOS5433_PIN_BANK_EINTG(5, 0x040, "gpr0", 0x08),
@@ -89,16 +95,19 @@ static const struct samsung_pin_bank_data exynos5433_pin_banks5[] __initconst =
 
 /* pin banks of exynos5433 pin-controller - IMEM */
 static const struct samsung_pin_bank_data exynos5433_pin_banks6[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS5433_PIN_BANK_EINTG(8, 0x000, "gpf0", 0x00),
 };
 
 /* pin banks of exynos5433 pin-controller - NFC */
 static const struct samsung_pin_bank_data exynos5433_pin_banks7[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS5433_PIN_BANK_EINTG(3, 0x000, "gpj0", 0x00),
 };
 
 /* pin banks of exynos5433 pin-controller - PERIC */
 static const struct samsung_pin_bank_data exynos5433_pin_banks8[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS5433_PIN_BANK_EINTG(6, 0x000, "gpv7", 0x00),
 	EXYNOS5433_PIN_BANK_EINTG(5, 0x020, "gpb0", 0x04),
 	EXYNOS5433_PIN_BANK_EINTG(8, 0x040, "gpc0", 0x08),
@@ -120,6 +129,7 @@ static const struct samsung_pin_bank_data exynos5433_pin_banks8[] __initconst =
 
 /* pin banks of exynos5433 pin-controller - TOUCH */
 static const struct samsung_pin_bank_data exynos5433_pin_banks9[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS5433_PIN_BANK_EINTG(3, 0x000, "gpj1", 0x00),
 };
 
@@ -267,6 +277,7 @@ const struct samsung_pinctrl_of_match_data exynos5433_of_data __initconst = {
 
 /* pin banks of exynos7 pin-controller - ALIVE */
 static const struct samsung_pin_bank_data exynos7_pin_banks0[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTW(8, 0x000, "gpa0", 0x00),
 	EXYNOS_PIN_BANK_EINTW(8, 0x020, "gpa1", 0x04),
 	EXYNOS_PIN_BANK_EINTW(8, 0x040, "gpa2", 0x08),
@@ -275,6 +286,7 @@ static const struct samsung_pin_bank_data exynos7_pin_banks0[] __initconst = {
 
 /* pin banks of exynos7 pin-controller - BUS0 */
 static const struct samsung_pin_bank_data exynos7_pin_banks1[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(5, 0x000, "gpb0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpc0", 0x04),
 	EXYNOS_PIN_BANK_EINTG(2, 0x040, "gpc1", 0x08),
@@ -294,31 +306,37 @@ static const struct samsung_pin_bank_data exynos7_pin_banks1[] __initconst = {
 
 /* pin banks of exynos7 pin-controller - NFC */
 static const struct samsung_pin_bank_data exynos7_pin_banks2[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(3, 0x000, "gpj0", 0x00),
 };
 
 /* pin banks of exynos7 pin-controller - TOUCH */
 static const struct samsung_pin_bank_data exynos7_pin_banks3[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(3, 0x000, "gpj1", 0x00),
 };
 
 /* pin banks of exynos7 pin-controller - FF */
 static const struct samsung_pin_bank_data exynos7_pin_banks4[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(4, 0x000, "gpg4", 0x00),
 };
 
 /* pin banks of exynos7 pin-controller - ESE */
 static const struct samsung_pin_bank_data exynos7_pin_banks5[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(5, 0x000, "gpv7", 0x00),
 };
 
 /* pin banks of exynos7 pin-controller - FSYS0 */
 static const struct samsung_pin_bank_data exynos7_pin_banks6[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpr4", 0x00),
 };
 
 /* pin banks of exynos7 pin-controller - FSYS1 */
 static const struct samsung_pin_bank_data exynos7_pin_banks7[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(4, 0x000, "gpr0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpr1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(5, 0x040, "gpr2", 0x08),
@@ -327,6 +345,7 @@ static const struct samsung_pin_bank_data exynos7_pin_banks7[] __initconst = {
 
 /* pin banks of exynos7 pin-controller - BUS1 */
 static const struct samsung_pin_bank_data exynos7_pin_banks8[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpf0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpf1", 0x04),
 	EXYNOS_PIN_BANK_EINTG(4, 0x060, "gpf2", 0x08),
@@ -340,6 +359,7 @@ static const struct samsung_pin_bank_data exynos7_pin_banks8[] __initconst = {
 };
 
 static const struct samsung_pin_bank_data exynos7_pin_banks9[] __initconst = {
+	/* Must start with EINTG banks, ordered by EINT group number. */
 	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz0", 0x00),
 	EXYNOS_PIN_BANK_EINTG(4, 0x020, "gpz1", 0x04),
 };
-- 
2.7.4
