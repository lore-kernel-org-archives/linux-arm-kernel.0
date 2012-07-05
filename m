From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  5 Jul 2012 15:10:26 +0200
Subject: [PATCH] i2c i.MX: Fix divider table
Message-ID: <1341493826-13861-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Measurements on i.MX1 and i.MX53 have shown that the divider values
in the datasheets are wrong. the values from first, third and fourth
column were all measured to be 8 higher than in the datasheet. It
should be safe to assume that the SoCs between i.MX1 and i.MX53 behave
the same as the i2c unit is unchanged since the i.MX1.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/i2c/busses/i2c-imx.c |   31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 8d6b504..aabbe31 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -98,22 +98,27 @@
  * Document Number: MC9328MXLRM, Rev. 5.1, 06/2007
  *
  * Duplicated divider values removed from list
+ *
+ * These values (mostly) do not match the ones in the datasheet because
+ * measurements have shown that the values are wrong. This was tested
+ * on i.MX1 and i.MX53, so it shoud be safe to assume that the SoCs in
+ * between behave the same.
  */
 
 static u16 __initdata i2c_clk_div[50][2] = {
-	{ 22,	0x20 }, { 24,	0x21 }, { 26,	0x22 }, { 28,	0x23 },
-	{ 30,	0x00 },	{ 32,	0x24 }, { 36,	0x25 }, { 40,	0x26 },
-	{ 42,	0x03 }, { 44,	0x27 },	{ 48,	0x28 }, { 52,	0x05 },
-	{ 56,	0x29 }, { 60,	0x06 }, { 64,	0x2A },	{ 72,	0x2B },
-	{ 80,	0x2C }, { 88,	0x09 }, { 96,	0x2D }, { 104,	0x0A },
-	{ 112,	0x2E }, { 128,	0x2F }, { 144,	0x0C }, { 160,	0x30 },
-	{ 192,	0x31 },	{ 224,	0x32 }, { 240,	0x0F }, { 256,	0x33 },
-	{ 288,	0x10 }, { 320,	0x34 },	{ 384,	0x35 }, { 448,	0x36 },
-	{ 480,	0x13 }, { 512,	0x37 }, { 576,	0x14 },	{ 640,	0x38 },
-	{ 768,	0x39 }, { 896,	0x3A }, { 960,	0x17 }, { 1024,	0x3B },
-	{ 1152,	0x18 }, { 1280,	0x3C }, { 1536,	0x3D }, { 1792,	0x3E },
-	{ 1920,	0x1B },	{ 2048,	0x3F }, { 2304,	0x1C }, { 2560,	0x1D },
-	{ 3072,	0x1E }, { 3840,	0x1F }
+	{ 30,	0x20 }, { 32,	0x21 }, { 34,	0x22 },	{ 36,	0x23 },
+	{ 38,	0x00 },	{ 40,	0x24 },	{ 44,	0x25 },	{ 48,	0x26 },
+	{ 50,	0x03 },	{ 52,	0x27 },	{ 56,	0x28 }, { 60,	0x05 },
+	{ 64,	0x29 }, { 68,	0x06 }, { 72,	0x2A },	{ 80,	0x2B },
+	{ 88,	0x2C }, { 96,	0x09 }, { 104,	0x2D }, { 112,	0x0A },
+	{ 120,	0x2E }, { 136,	0x2F }, { 152,	0x0C },	{ 168,	0x30 },
+	{ 200,	0x31 }, { 232,	0x32 }, { 248,	0x0F },	{ 264,	0x33 },
+	{ 288,	0x10 },	{ 328,	0x34 },	{ 392,	0x35 },	{ 456,	0x36 },
+	{ 480,	0x13 },	{ 520,	0x37 },	{ 576,	0x14 },	{ 648,	0x38 },
+	{ 776,	0x39 },	{ 904,	0x3A },	{ 960,	0x17 },	{ 1032,	0x3B },
+	{ 1152,	0x18 },	{ 1288,	0x3C },	{ 1544,	0x3D },	{ 1800,	0x3E },
+	{ 1920,	0x1B },	{ 2048,	0x3F },	{ 2304,	0x1C },	{ 2560,	0x1D },
+	{ 3072,	0x1E },	{ 3840,	0x1F }
 };
 
 struct imx_i2c_struct {
-- 
1.7.10
