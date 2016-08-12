From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 12 Aug 2016 14:34:03 +0200
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Enable SECCOMP
In-Reply-To: <1471005243-6409-1-git-send-email-k.kozlowski@samsung.com>
References: <1471005243-6409-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1471005243-6409-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Systemd already supports seccomp.  It seems some distros are building
systemd with seccomp, e.g. Arch on ARM, thus leading to boot errors:

systemd-logind.service: Failed at step SECCOMP spawning /usr/lib/systemd/systemd-logind: Invalid argument

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 7db8dce3da5f..0ccaa519f588 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -126,6 +126,7 @@ CONFIG_SMP=y
 CONFIG_NR_CPUS=16
 CONFIG_HIGHPTE=y
 CONFIG_CMA=y
+CONFIG_SECCOMP=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_KEXEC=y
-- 
1.9.1
