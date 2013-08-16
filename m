From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 16 Aug 2013 13:28:28 -0700
Subject: [PATCH v2] ARM: vexpress_defconfig: Enable voltage regulators
Message-ID: <1376684908-20445-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable voltage regulators by default for versatile express.

This should work on all verstatile express platforms and not enabling it
prevents a defconfig'ed kernel from using the SD card controller on the
qemu emulated platform, which is unfortunate for first-time casual
users.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Jon Medhurst (Tixy) <tixy@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---

Changelog[v1 -> v2]:
 - Only enabling CONFIG_REGULATOR is sufficient to boot qemu guests as
   pointedout by Tixy.

 arch/arm/configs/vexpress_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/vexpress_defconfig b/arch/arm/configs/vexpress_defconfig
index f2de51f..d46c22a 100644
--- a/arch/arm/configs/vexpress_defconfig
+++ b/arch/arm/configs/vexpress_defconfig
@@ -138,3 +138,4 @@ CONFIG_DEBUG_LL=y
 CONFIG_EARLY_PRINTK=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
+CONFIG_REGULATOR=y
-- 
1.7.10.4
