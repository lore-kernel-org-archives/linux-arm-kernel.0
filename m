From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 25 Aug 2015 17:22:10 +0100
Subject: [PATCH 3/3] [media] c8sectpfe: Remove select on undefined LIBELF_32
In-Reply-To: <1440519730-486-1-git-send-email-peter.griffin@linaro.org>
References: <1440519730-486-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1440519730-486-4-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LIBELF_32 is not defined in Kconfig, and is left over legacy
which is not required in the upstream driver, so remove it.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Suggested-by: Valentin Rothberg <valentinrothberg@gmail.com>
---
 drivers/media/platform/sti/c8sectpfe/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/sti/c8sectpfe/Kconfig b/drivers/media/platform/sti/c8sectpfe/Kconfig
index d1bfd4c..b9ec667 100644
--- a/drivers/media/platform/sti/c8sectpfe/Kconfig
+++ b/drivers/media/platform/sti/c8sectpfe/Kconfig
@@ -1,7 +1,6 @@
 config DVB_C8SECTPFE
 	tristate "STMicroelectronics C8SECTPFE DVB support"
 	depends on DVB_CORE && I2C && (ARCH_STI || ARCH_MULTIPLATFORM)
-	select LIBELF_32
 	select FW_LOADER
 	select FW_LOADER_USER_HELPER_FALLBACK
 	select DEBUG_FS
-- 
1.9.1
