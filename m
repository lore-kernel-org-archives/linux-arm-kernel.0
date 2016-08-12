From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 12 Aug 2016 14:34:02 +0200
Subject: [PATCH 1/2] ARM: exynos_defconfig: Enable SECCOMP
Message-ID: <1471005243-6409-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Systemd already supports seccomp.  It seems some distros are building
systemd with seccomp, e.g. Arch on ARM, thus leading to boot errors:

systemd-logind.service: Failed at step SECCOMP spawning /usr/lib/systemd/systemd-logind: Invalid argument

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 81862a77dddf..5476be3be686 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -17,6 +17,7 @@ CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_CMA=y
+CONFIG_SECCOMP=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
-- 
1.9.1
