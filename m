From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Wed,  8 Feb 2017 15:56:20 +0000
Subject: [PATCH -next] reset: uniphier: fix non static symbol warnings
Message-ID: <20170208155620.25055-1-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fixes the following sparse warnings:

drivers/reset/reset-uniphier.c:68:34: warning:
 symbol 'uniphier_sld3_sys_reset_data' was not declared. Should it be static?
drivers/reset/reset-uniphier.c:73:34: warning:
 symbol 'uniphier_pro4_sys_reset_data' was not declared. Should it be static?
drivers/reset/reset-uniphier.c:81:34: warning:
 symbol 'uniphier_pro5_sys_reset_data' was not declared. Should it be static?
drivers/reset/reset-uniphier.c:89:34: warning:
 symbol 'uniphier_pxs2_sys_reset_data' was not declared. Should it be static?
drivers/reset/reset-uniphier.c:103:34: warning:
 symbol 'uniphier_ld11_sys_reset_data' was not declared. Should it be static?
drivers/reset/reset-uniphier.c:108:34: warning:
 symbol 'uniphier_ld20_sys_reset_data' was not declared. Should it be static?
drivers/reset/reset-uniphier.c:137:34: warning:
 symbol 'uniphier_sld3_mio_reset_data' was not declared. Should it be static?
drivers/reset/reset-uniphier.c:157:34: warning:
 symbol 'uniphier_pro5_sd_reset_data' was not declared. Should it be static?
drivers/reset/reset-uniphier.c:174:34: warning:
 symbol 'uniphier_ld4_peri_reset_data' was not declared. Should it be static?
drivers/reset/reset-uniphier.c:187:34: warning:
 symbol 'uniphier_pro4_peri_reset_data' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/reset/reset-uniphier.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
index 9c11be3..7af60bc 100644
--- a/drivers/reset/reset-uniphier.c
+++ b/drivers/reset/reset-uniphier.c
@@ -65,12 +65,12 @@ struct uniphier_reset_data {
 #define UNIPHIER_PRO4_SYS_RESET_USB3(id, ch)		\
 	UNIPHIER_RESETX((id), 0x2000 + 0x4 * (ch), 17)
 
-const struct uniphier_reset_data uniphier_sld3_sys_reset_data[] = {
+static const struct uniphier_reset_data uniphier_sld3_sys_reset_data[] = {
 	UNIPHIER_SLD3_SYS_RESET_STDMAC(8),	/* Ether, HSC, MIO */
 	UNIPHIER_RESET_END,
 };
 
-const struct uniphier_reset_data uniphier_pro4_sys_reset_data[] = {
+static const struct uniphier_reset_data uniphier_pro4_sys_reset_data[] = {
 	UNIPHIER_SLD3_SYS_RESET_STDMAC(8),	/* HSC, MIO, RLE */
 	UNIPHIER_PRO4_SYS_RESET_GIO(12),	/* Ether, SATA, USB3 */
 	UNIPHIER_PRO4_SYS_RESET_USB3(14, 0),
@@ -78,7 +78,7 @@ const struct uniphier_reset_data uniphier_pro4_sys_reset_data[] = {
 	UNIPHIER_RESET_END,
 };
 
-const struct uniphier_reset_data uniphier_pro5_sys_reset_data[] = {
+static const struct uniphier_reset_data uniphier_pro5_sys_reset_data[] = {
 	UNIPHIER_SLD3_SYS_RESET_STDMAC(8),	/* HSC */
 	UNIPHIER_PRO4_SYS_RESET_GIO(12),	/* PCIe, USB3 */
 	UNIPHIER_PRO4_SYS_RESET_USB3(14, 0),
@@ -86,7 +86,7 @@ const struct uniphier_reset_data uniphier_pro5_sys_reset_data[] = {
 	UNIPHIER_RESET_END,
 };
 
-const struct uniphier_reset_data uniphier_pxs2_sys_reset_data[] = {
+static const struct uniphier_reset_data uniphier_pxs2_sys_reset_data[] = {
 	UNIPHIER_SLD3_SYS_RESET_STDMAC(8),	/* HSC, RLE */
 	UNIPHIER_PRO4_SYS_RESET_USB3(14, 0),
 	UNIPHIER_PRO4_SYS_RESET_USB3(15, 1),
@@ -100,12 +100,12 @@ const struct uniphier_reset_data uniphier_pxs2_sys_reset_data[] = {
 	UNIPHIER_RESET_END,
 };
 
-const struct uniphier_reset_data uniphier_ld11_sys_reset_data[] = {
+static const struct uniphier_reset_data uniphier_ld11_sys_reset_data[] = {
 	UNIPHIER_LD11_SYS_RESET_STDMAC(8),	/* HSC, MIO */
 	UNIPHIER_RESET_END,
 };
 
-const struct uniphier_reset_data uniphier_ld20_sys_reset_data[] = {
+static const struct uniphier_reset_data uniphier_ld20_sys_reset_data[] = {
 	UNIPHIER_LD11_SYS_RESET_STDMAC(8),	/* HSC */
 	UNIPHIER_LD20_SYS_RESET_GIO(12),	/* PCIe, USB3 */
 	UNIPHIER_RESETX(16, 0x200c, 12),	/* USB30-PHY0 */
@@ -134,7 +134,7 @@ const struct uniphier_reset_data uniphier_ld20_sys_reset_data[] = {
 #define UNIPHIER_MIO_RESET_DMAC(id)			\
 	UNIPHIER_RESETX((id), 0x110, 17)
 
-const struct uniphier_reset_data uniphier_sld3_mio_reset_data[] = {
+static const struct uniphier_reset_data uniphier_sld3_mio_reset_data[] = {
 	UNIPHIER_MIO_RESET_SD(0, 0),
 	UNIPHIER_MIO_RESET_SD(1, 1),
 	UNIPHIER_MIO_RESET_SD(2, 2),
@@ -154,7 +154,7 @@ const struct uniphier_reset_data uniphier_sld3_mio_reset_data[] = {
 	UNIPHIER_RESET_END,
 };
 
-const struct uniphier_reset_data uniphier_pro5_sd_reset_data[] = {
+static const struct uniphier_reset_data uniphier_pro5_sd_reset_data[] = {
 	UNIPHIER_MIO_RESET_SD(0, 0),
 	UNIPHIER_MIO_RESET_SD(1, 1),
 	UNIPHIER_MIO_RESET_EMMC_HW_RESET(6, 1),
@@ -171,7 +171,7 @@ const struct uniphier_reset_data uniphier_pro5_sd_reset_data[] = {
 #define UNIPHIER_PERI_RESET_FI2C(id, ch)		\
 	UNIPHIER_RESETX((id), 0x114, 24 + (ch))
 
-const struct uniphier_reset_data uniphier_ld4_peri_reset_data[] = {
+static const struct uniphier_reset_data uniphier_ld4_peri_reset_data[] = {
 	UNIPHIER_PERI_RESET_UART(0, 0),
 	UNIPHIER_PERI_RESET_UART(1, 1),
 	UNIPHIER_PERI_RESET_UART(2, 2),
@@ -184,7 +184,7 @@ const struct uniphier_reset_data uniphier_ld4_peri_reset_data[] = {
 	UNIPHIER_RESET_END,
 };
 
-const struct uniphier_reset_data uniphier_pro4_peri_reset_data[] = {
+static const struct uniphier_reset_data uniphier_pro4_peri_reset_data[] = {
 	UNIPHIER_PERI_RESET_UART(0, 0),
 	UNIPHIER_PERI_RESET_UART(1, 1),
 	UNIPHIER_PERI_RESET_UART(2, 2),
