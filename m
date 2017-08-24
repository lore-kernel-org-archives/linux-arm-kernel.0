From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 24 Aug 2017 10:49:28 +0800
Subject: [PATCH v2] binder: allow ANDROID_BINDER_IPC_32BIT to be unselected on
 32bit ARM
Message-ID: <20170824024928.707-1-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As noted in commit d0bdff0db809 ("staging: Fix build issues with new
binder API"), we can add back the choice for 32bit ARM "once a 64bit
__get_user_asm_* implementation is merged." Commit e38361d032f1 ("ARM:
8091/2: add get_user() support for 8 byte types") has added the
support, so it's time to allow ANDROID_BINDER_IPC_32BIT to be
unselected on 32bit ARM so that the 64bit ABI can be tested/used on
32bit systems.

This change allows running the same 32bit userspace build no matter
the kernel is 64bit or 32bit.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 Since v1:
  - fix the commit msg 

 drivers/android/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/Kconfig b/drivers/android/Kconfig
index 832e885349b1..aca5dc30b97b 100644
--- a/drivers/android/Kconfig
+++ b/drivers/android/Kconfig
@@ -32,7 +32,7 @@ config ANDROID_BINDER_DEVICES
 	  therefore logically separated from the other devices.
 
 config ANDROID_BINDER_IPC_32BIT
-	bool
+	bool "Use old (Android 4.4 and earlier) 32-bit binder API"
 	depends on !64BIT && ANDROID_BINDER_IPC
 	default y
 	---help---
-- 
2.14.1
