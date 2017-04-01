From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat,  1 Apr 2017 15:59:22 +0200
Subject: [PATCH v2 2/2] pinctrl: meson: meson8b: rename the NAND DQS pin
 definitions
In-Reply-To: <20170401135922.1288-1-martin.blumenstingl@googlemail.com>
References: <20170325184350.7677-1-martin.blumenstingl@googlemail.com>
 <20170401135922.1288-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170401135922.1288-3-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NAND DQS pins are currently named nand_dqs_0 and nand_dqs_1.
However, they both seem to have the same function, just exposed on
different pins (unlike the ethernet TX pins for example, where there's
eth_txd0..3 - all of these can be active at the same time as they are
different data lines).
Rename the NAND DQS pins to nand_dqs_15 and nand_dqs_18 to reflect that
it's the same functionality just exposed on different pins (BOOT_15 and
BOOT_18).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pinctrl/meson/pinctrl-meson8b.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson8b.c b/drivers/pinctrl/meson/pinctrl-meson8b.c
index f87ef5a0ee6c..bf747eb1f3f4 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8b.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8b.c
@@ -267,8 +267,8 @@ static const unsigned int nand_ale_pins[]	= { PIN(BOOT_11, 0) };
 static const unsigned int nand_cle_pins[]	= { PIN(BOOT_12, 0) };
 static const unsigned int nand_wen_clk_pins[]	= { PIN(BOOT_13, 0) };
 static const unsigned int nand_ren_clk_pins[]	= { PIN(BOOT_14, 0) };
-static const unsigned int nand_dqs_0_pins[]	= { PIN(BOOT_15, 0) };
-static const unsigned int nand_dqs_1_pins[]	= { PIN(BOOT_18, 0) };
+static const unsigned int nand_dqs_15_pins[]	= { PIN(BOOT_15, 0) };
+static const unsigned int nand_dqs_18_pins[]	= { PIN(BOOT_18, 0) };
 
 static const unsigned int sdxc_d0_c_pins[]	= { PIN(BOOT_0, 0)};
 static const unsigned int sdxc_d13_c_pins[]	= { PIN(BOOT_1, 0), PIN(BOOT_2, 0),
@@ -527,8 +527,8 @@ static struct meson_pmx_group meson8b_cbus_groups[] = {
 	GROUP(nand_cle,		2,	20),
 	GROUP(nand_wen_clk,	2,	19),
 	GROUP(nand_ren_clk,	2,	18),
-	GROUP(nand_dqs_0,	2,	27),
-	GROUP(nand_dqs_1,	2,	28),
+	GROUP(nand_dqs_15,	2,	27),
+	GROUP(nand_dqs_18,	2,	28),
 	GROUP(sdxc_d0_c,	4,	30),
 	GROUP(sdxc_d13_c,	4,	29),
 	GROUP(sdxc_d47_c,	4,	28),
@@ -739,8 +739,8 @@ static const char * const sdxc_c_groups[] = {
 static const char * const nand_groups[] = {
 	"nand_io", "nand_io_ce0", "nand_io_ce1",
 	"nand_io_rb0", "nand_ale", "nand_cle",
-	"nand_wen_clk", "nand_ren_clk", "nand_dqs_0",
-	"nand_dqs_1"
+	"nand_wen_clk", "nand_ren_clk", "nand_dqs_15",
+	"nand_dqs_18"
 };
 
 static const char * const nor_groups[] = {
-- 
2.12.1
