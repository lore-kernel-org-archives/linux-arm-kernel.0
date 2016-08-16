From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 16 Aug 2016 11:08:14 -0400
Subject: [RESEND PATCH] ARM: multi_v7_defconfig: Build Atmel maXTouch driver
 as a module
Message-ID: <1471360094-27637-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver is for a trackpad device so is not needed for booting and
makes more sense to have it as module to reduce the kernel image size.

It was probably enabled as built-in because module autoload was not
working when the I2C device was registered by OF but this got fixed
in commit b7d21058b40b ("Input: atmel_mxt_ts - add maxtouch to I2C
table for module autoload") so it's safe to enable as a module now.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 arch/arm/configs/multi_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2c8665cd9dc5..5d4fb28fb34f 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -277,7 +277,7 @@ CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_MOUSE_CYAPA=m
 CONFIG_MOUSE_ELAN_I2C=y
 CONFIG_INPUT_TOUCHSCREEN=y
-CONFIG_TOUCHSCREEN_ATMEL_MXT=y
+CONFIG_TOUCHSCREEN_ATMEL_MXT=m
 CONFIG_TOUCHSCREEN_MMS114=m
 CONFIG_TOUCHSCREEN_ST1232=m
 CONFIG_TOUCHSCREEN_STMPE=y
-- 
2.5.5
