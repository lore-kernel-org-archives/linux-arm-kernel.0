From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu, 10 Jul 2014 10:04:09 +0800
Subject: [PATCH v10 10/11] ARM: hisi: enable erratum 798181 of A15 on HiP04
In-Reply-To: <1404957850-13340-1-git-send-email-haojian.zhuang@linaro.org>
References: <1404957850-13340-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1404957850-13340-11-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kefeng Wang <kefeng.wang@linaro.org>

The commit 93dc688 (ARM: 7684/1: errata: Workaround for Cortex-A15
erratum 798181 (TLBI/DSB operations)) introduced a workaround for
Cortex-A15 erratum 798181. Enable it for HIP04(Cortex-a15 r3p2).

Signed-off-by: Kefeng Wang <kefeng.wang@linaro.org>
Singed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/mach-hisi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index a458f28..8d92e99 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -21,6 +21,7 @@ config ARCH_HI3xxx
 
 config ARCH_HIP04
 	bool "Hisilicon HiP04 Cortex A15 family" if ARCH_MULTI_V7
+	select ARM_ERRATA_798181 if SMP
 	select HAVE_ARM_ARCH_TIMER
 	select MCPM if SMP
 	select MCPM_QUAD_CLUSTER if SMP
-- 
1.9.1
