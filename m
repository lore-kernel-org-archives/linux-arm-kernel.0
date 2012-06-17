From: linus.walleij@stericsson.com (Linus Walleij)
Date: Sun, 17 Jun 2012 19:57:17 +0200
Subject: [PATCH] ARM: ux500: bump i2c bus speed to 400kHz
Message-ID: <1339955837-26691-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Some recent discussion revealed inconsistency in the board file
for the MOP500 family. The board can very well do 400kHz on
the I2C busses, so make it do that.

Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 9c74ac5..e441bd7 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -354,13 +354,13 @@ static struct nmk_i2c_controller u8500_i2c##id##_data = { \
 /*
  * The board uses 4 i2c controllers, initialize all of
  * them with slave data setup time of 250 ns,
- * Tx & Rx FIFO threshold values as 8 and standard
+ * Tx & Rx FIFO threshold values as 1 resp. 8 and fast
  * mode of operation
  */
-U8500_I2C_CONTROLLER(0, 0xe, 1, 8, 100000, 200, I2C_FREQ_MODE_FAST);
-U8500_I2C_CONTROLLER(1, 0xe, 1, 8, 100000, 200, I2C_FREQ_MODE_FAST);
-U8500_I2C_CONTROLLER(2,	0xe, 1, 8, 100000, 200, I2C_FREQ_MODE_FAST);
-U8500_I2C_CONTROLLER(3,	0xe, 1, 8, 100000, 200, I2C_FREQ_MODE_FAST);
+U8500_I2C_CONTROLLER(0, 0xe, 1, 8, 400000, 200, I2C_FREQ_MODE_FAST);
+U8500_I2C_CONTROLLER(1, 0xe, 1, 8, 400000, 200, I2C_FREQ_MODE_FAST);
+U8500_I2C_CONTROLLER(2,	0xe, 1, 8, 400000, 200, I2C_FREQ_MODE_FAST);
+U8500_I2C_CONTROLLER(3,	0xe, 1, 8, 400000, 200, I2C_FREQ_MODE_FAST);
 
 static void __init mop500_i2c_init(struct device *parent)
 {
-- 
1.7.9.2
