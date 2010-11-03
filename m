From: zhangfei.gao@marvell.com (Zhangfei Gao)
Date: Wed, 3 Nov 2010 01:15:32 -0400
Subject: [PATCH 2/2] ARM: mmp2: add sd card to jasper
Message-ID: <mailman.11.1288775236.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 arch/arm/mach-mmp/jasper.c |   47 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/jasper.c b/arch/arm/mach-mmp/jasper.c
index 2a684fa..757f251 100644
--- a/arch/arm/mach-mmp/jasper.c
+++ b/arch/arm/mach-mmp/jasper.c
@@ -67,6 +67,36 @@ static unsigned long jasper_pin_config[] __initdata = {

 	/* PMIC */
 	PMIC_PMIC_INT | MFP_LPM_EDGE_FALL,
+
+	/* MMC1 */
+	GPIO131_MMC1_DAT3,
+	GPIO132_MMC1_DAT2,
+	GPIO133_MMC1_DAT1,
+	GPIO134_MMC1_DAT0,
+	GPIO136_MMC1_CMD,
+	GPIO139_MMC1_CLK,
+	GPIO140_MMC1_CD,
+	GPIO141_MMC1_WP,
+
+	/* MMC2 */
+	GPIO37_MMC2_DAT3,
+	GPIO38_MMC2_DAT2,
+	GPIO39_MMC2_DAT1,
+	GPIO40_MMC2_DAT0,
+	GPIO41_MMC2_CMD,
+	GPIO42_MMC2_CLK,
+
+	/* MMC3 */
+	GPIO165_MMC3_DAT7,
+	GPIO162_MMC3_DAT6,
+	GPIO166_MMC3_DAT5,
+	GPIO163_MMC3_DAT4,
+	GPIO167_MMC3_DAT3,
+	GPIO164_MMC3_DAT2,
+	GPIO168_MMC3_DAT1,
+	GPIO111_MMC3_DAT0,
+	GPIO112_MMC3_CMD,
+	GPIO151_MMC3_CLK,
 };

 static struct regulator_consumer_supply max8649_supply[] = {
@@ -123,6 +153,19 @@ static struct i2c_board_info jasper_twsi1_info[] = {
 	},
 };

+#if defined(CONFIG_MMC_SDHCI_PXA)
+
+static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc0 = {
+	.max_speed	= 25000000,
+};
+
+static void __init mmp2_init_mmc(void)
+{
+	mmp2_add_sdh(0, &mmp2_sdh_platdata_mmc0); /* SD/MMC */
+}
+
+#endif
+
 static void __init jasper_init(void)
 {
 	mfp_config(ARRAY_AND_SIZE(jasper_pin_config));
@@ -132,6 +175,10 @@ static void __init jasper_init(void)
 	mmp2_add_uart(3);
 	mmp2_add_twsi(1, NULL, ARRAY_AND_SIZE(jasper_twsi1_info));

+#if defined(CONFIG_MMC_SDHCI_PXA)
+	mmp2_init_mmc();
+#endif
+
 	regulator_has_full_constraints();
 }

-- 
1.7.0.4

--001636c5a8e2f712de0494225d0d
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0002-ARM-mmp2-add-sd-card-to-jasper.patch"
Content-Disposition: attachment; 
	filename="0002-ARM-mmp2-add-sd-card-to-jasper.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gg1zgzhe0

RnJvbSA0M2FkNGZmNDlkNmU5NGUzMjQ2ODc3NmEyNzhiYWFiYzQ2M2E2MTNmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNv
bT4KRGF0ZTogV2VkLCAzIE5vdiAyMDEwIDAxOjE1OjMyIC0wNDAwClN1YmplY3Q6IFtQQVRDSCAy
LzJdIEFSTTogbW1wMjogYWRkIHNkIGNhcmQgdG8gamFzcGVyCgpTaWduZWQtb2ZmLWJ5OiBaaGFu
Z2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNvbT4KLS0tCiBhcmNoL2FybS9tYWNoLW1t
cC9qYXNwZXIuYyB8ICAgNDcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysKIDEgZmlsZXMgY2hhbmdlZCwgNDcgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW1tcC9qYXNwZXIuYyBiL2FyY2gvYXJtL21hY2gt
bW1wL2phc3Blci5jCmluZGV4IDJhNjg0ZmEuLjc1N2YyNTEgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJt
L21hY2gtbW1wL2phc3Blci5jCisrKyBiL2FyY2gvYXJtL21hY2gtbW1wL2phc3Blci5jCkBAIC02
Nyw2ICs2NywzNiBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZyBqYXNwZXJfcGluX2NvbmZpZ1tdIF9f
aW5pdGRhdGEgPSB7CiAKIAkvKiBQTUlDICovCiAJUE1JQ19QTUlDX0lOVCB8IE1GUF9MUE1fRURH
RV9GQUxMLAorCisJLyogTU1DMSAqLworCUdQSU8xMzFfTU1DMV9EQVQzLAorCUdQSU8xMzJfTU1D
MV9EQVQyLAorCUdQSU8xMzNfTU1DMV9EQVQxLAorCUdQSU8xMzRfTU1DMV9EQVQwLAorCUdQSU8x
MzZfTU1DMV9DTUQsCisJR1BJTzEzOV9NTUMxX0NMSywKKwlHUElPMTQwX01NQzFfQ0QsCisJR1BJ
TzE0MV9NTUMxX1dQLAorCisJLyogTU1DMiAqLworCUdQSU8zN19NTUMyX0RBVDMsCisJR1BJTzM4
X01NQzJfREFUMiwKKwlHUElPMzlfTU1DMl9EQVQxLAorCUdQSU80MF9NTUMyX0RBVDAsCisJR1BJ
TzQxX01NQzJfQ01ELAorCUdQSU80Ml9NTUMyX0NMSywKKworCS8qIE1NQzMgKi8KKwlHUElPMTY1
X01NQzNfREFUNywKKwlHUElPMTYyX01NQzNfREFUNiwKKwlHUElPMTY2X01NQzNfREFUNSwKKwlH
UElPMTYzX01NQzNfREFUNCwKKwlHUElPMTY3X01NQzNfREFUMywKKwlHUElPMTY0X01NQzNfREFU
MiwKKwlHUElPMTY4X01NQzNfREFUMSwKKwlHUElPMTExX01NQzNfREFUMCwKKwlHUElPMTEyX01N
QzNfQ01ELAorCUdQSU8xNTFfTU1DM19DTEssCiB9OwogCiBzdGF0aWMgc3RydWN0IHJlZ3VsYXRv
cl9jb25zdW1lcl9zdXBwbHkgbWF4ODY0OV9zdXBwbHlbXSA9IHsKQEAgLTEyMyw2ICsxNTMsMTkg
QEAgc3RhdGljIHN0cnVjdCBpMmNfYm9hcmRfaW5mbyBqYXNwZXJfdHdzaTFfaW5mb1tdID0gewog
CX0sCiB9OwogCisjaWYgZGVmaW5lZChDT05GSUdfTU1DX1NESENJX1BYQSkKKworc3RhdGljIHN0
cnVjdCBzZGhjaV9weGFfcGxhdGRhdGEgbW1wMl9zZGhfcGxhdGRhdGFfbW1jMCA9IHsKKwkubWF4
X3NwZWVkCT0gMjUwMDAwMDAsCit9OworCitzdGF0aWMgdm9pZCBfX2luaXQgbW1wMl9pbml0X21t
Yyh2b2lkKQoreworCW1tcDJfYWRkX3NkaCgwLCAmbW1wMl9zZGhfcGxhdGRhdGFfbW1jMCk7IC8q
IFNEL01NQyAqLworfQorCisjZW5kaWYKKwogc3RhdGljIHZvaWQgX19pbml0IGphc3Blcl9pbml0
KHZvaWQpCiB7CiAJbWZwX2NvbmZpZyhBUlJBWV9BTkRfU0laRShqYXNwZXJfcGluX2NvbmZpZykp
OwpAQCAtMTMyLDYgKzE3NSwxMCBAQCBzdGF0aWMgdm9pZCBfX2luaXQgamFzcGVyX2luaXQodm9p
ZCkKIAltbXAyX2FkZF91YXJ0KDMpOwogCW1tcDJfYWRkX3R3c2koMSwgTlVMTCwgQVJSQVlfQU5E
X1NJWkUoamFzcGVyX3R3c2kxX2luZm8pKTsKIAorI2lmIGRlZmluZWQoQ09ORklHX01NQ19TREhD
SV9QWEEpCisJbW1wMl9pbml0X21tYygpOworI2VuZGlmCisKIAlyZWd1bGF0b3JfaGFzX2Z1bGxf
Y29uc3RyYWludHMoKTsKIH0KIAotLSAKMS43LjAuNAoK
--001636c5a8e2f712de0494225d0d--
