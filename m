From: panda@chelcom.ru (Andrey Porodko)
Date: Sat, 5 Dec 2009 15:54:42 +0500
Subject: [PATCH] Neuros OSD2 board platform code patch for supporting msp430
 microcontroller and sound soc.
Message-ID: <mailman.69.1260110450.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrey Porodko <panda@chelcom.ru>
---
 arch/arm/mach-davinci/board-neuros-osd2.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c
b/arch/arm/mach-davinci/board-neuros-osd2.c
index bd9ca07..28b3d67 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -202,6 +202,12 @@ static struct davinci_i2c_platform_data
ntosd2_i2c_pdata = {
 };
 
 static struct i2c_board_info __initdata ntosd2_i2c_info[] =  {
+    {                    /* MSP430 interface    */
+        I2C_BOARD_INFO("davinci_msp", NTOSD2_MSP430_I2C_ADDR),
+    },
+    {
+        I2C_BOARD_INFO("tlv320aic3x", NTOSD2_AUDIOSOC_I2C_ADDR),
+    },
 };
 
 static    int ntosd2_init_i2c(void)
-- 
1.5.6.5


-- 
Best regards
Andrey A. Porodko
 
