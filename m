From: khilman@linaro.org (Kevin Hilman)
Date: Mon,  7 Oct 2013 11:00:46 -0700
Subject: [PATCH stable] ARM: multi_v7_defconfig: enable ARM_ATAG_DTB_COMPAT
Message-ID: <1381168846-11076-1-git-send-email-khilman@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Olof Johansson <olof@lixom.net>

Without this, legacy platforms that can boot with a multiplatform
kernel but that need the DTB to be appended, won't have a way to pass
firmware-set bootargs to the kernel.

This is needed to boot multi_v7_defconfig on snowball, for instance.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
Greg, This is in Linus' tree as commit a0396b9bd5a4a7baf598b60d2ca53c605c440a42
but we neglected to flag this for stable even though it's needed for
older kernels too.  Please cherry-pick into stable.  

Intended for v3.11.y.  Thanks.
 
 arch/arm/configs/multi_v7_defconfig | 1 +
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
1.8.3
