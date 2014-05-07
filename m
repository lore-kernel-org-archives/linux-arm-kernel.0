From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed,  7 May 2014 22:44:46 +0800
Subject: [PATCH v5 12/14] ARM: hisi: enable erratum 798181 of A15 on HiP04
In-Reply-To: <1399473888-12947-1-git-send-email-haojian.zhuang@linaro.org>
References: <1399473888-12947-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1399473888-12947-13-git-send-email-haojian.zhuang@linaro.org>
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
index 17af1d2..5c0602d 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -21,6 +21,7 @@ config ARCH_HI3xxx
 
 config ARCH_HIP04
 	bool "Hisilicon HiP04 Cortex A15 family" if ARCH_MULTI_V7_LPAE
+	select ARM_ERRATA_798181 if SMP
 	select HAVE_ARM_ARCH_TIMER
 	select MCPM if SMP
 	select MCPM_QUAD_CLUSTER if SMP
-- 
1.9.1
