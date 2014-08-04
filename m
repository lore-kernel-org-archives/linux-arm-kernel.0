From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 04 Aug 2014 18:59:21 +0200
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: Enable
 ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND
Message-ID: <5084600.YbBVvXy6Ug@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At present on atag based legacy bootloaders, the provided kernel commandline
will be used unchanged, potentially using obscure parameters for outdated
vendor-kernel drivers.

Therefore allow them to be extended by known-good parameters from the
bootargs property of the dtb.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 1bf198b..16a42a5 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -80,6 +80,7 @@ CONFIG_HIGHPTE=y
 CONFIG_CMA=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
+CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND=y
 CONFIG_KEXEC=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_STAT_DETAILS=y
-- 
2.0.1
