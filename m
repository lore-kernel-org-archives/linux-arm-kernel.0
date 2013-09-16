From: olof@lixom.net (Olof Johansson)
Date: Mon, 16 Sep 2013 09:01:24 -0700
Subject: [PATCH] ARM: multi_v7_defconfig: enable ARM_ATAG_DTB_COMPAT
Message-ID: <1379347284-12422-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this, legacy platforms that can boot with a multiplatform
kernel but that need the DTB to be appended, won't have a way to pass
firmware-set bootargs to the kernel.

This is needed to boot multi_v7_defconfig on snowball, for instance.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/configs/multi_v7_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 6e572c6..aba4ec7 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -46,6 +46,7 @@ CONFIG_ARCH_ZYNQ=y
 CONFIG_SMP=y
 CONFIG_HIGHPTE=y
 CONFIG_ARM_APPENDED_DTB=y
+CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_NET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
-- 
1.7.10.4
