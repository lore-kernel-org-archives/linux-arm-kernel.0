From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 10 Jun 2013 14:50:15 -0700
Subject: [PATCH] ARM: vexpress_defconfig: Enable voltage regulators
Message-ID: <1370901015-4159-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the Versatile Express voltage regulators by default.

This should work on all verstatile express platforms and not enabling it
prevents a defconfig'ed kernel from using the SD card controller on the
qemu emulated platform, which is unfortunate for first-time casual
users.

Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/configs/vexpress_defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/vexpress_defconfig b/arch/arm/configs/vexpress_defconfig
index f2de51f..17104d9 100644
--- a/arch/arm/configs/vexpress_defconfig
+++ b/arch/arm/configs/vexpress_defconfig
@@ -138,3 +138,6 @@ CONFIG_DEBUG_LL=y
 CONFIG_EARLY_PRINTK=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_REGULATOR_VEXPRESS=y
-- 
1.7.9.5
