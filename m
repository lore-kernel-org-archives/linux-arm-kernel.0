From: daniel.diaz@linaro.org (=?UTF-8?q?Daniel=20D=C3=ADaz?=)
Date: Thu, 14 Jun 2018 17:50:27 -0500
Subject: [PATCH 2/2] arm: multi_v7_defconfig: Enable KSM.
In-Reply-To: <1529016629-2948-1-git-send-email-daniel.diaz@linaro.org>
References: <1529016629-2948-1-git-send-email-daniel.diaz@linaro.org>
Message-ID: <1529016629-2948-2-git-send-email-daniel.diaz@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per the documentation, Kernel Samepage Merging (available
since 2.6.32) is a memory-saving de-duplication feature,
enabled by CONFIG_KSM=y and activated via sysfs. More
information can be found here:
  https://www.kernel.org/doc/Documentation/vm/ksm.txt

When enabled in the kernel, the default is to not do anything
at all, until it is activated at run-time with:
  echo 1 > /sys/kernel/mm/ksm/run

Signed-off-by: Daniel D?az <daniel.diaz@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 7e1c543..79eedf4d 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -133,6 +133,7 @@ CONFIG_SMP=y
 CONFIG_NR_CPUS=16
 CONFIG_HIGHPTE=y
 CONFIG_CMA=y
+CONFIG_KSM=y
 CONFIG_SECCOMP=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
-- 
2.7.4
