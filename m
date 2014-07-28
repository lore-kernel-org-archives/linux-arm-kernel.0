From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 28 Jul 2014 21:57:54 +0800
Subject: [PATCH v15 10/12] ARM: hisi: enable erratum 798181 of A15 on HiP04
In-Reply-To: <1406555876-11989-1-git-send-email-haojian.zhuang@linaro.org>
References: <1406555876-11989-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1406555876-11989-11-git-send-email-haojian.zhuang@linaro.org>
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
index 2a36fb7..075772b 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -24,6 +24,7 @@ config ARCH_HI3xxx
 
 config ARCH_HIP04
 	bool "Hisilicon HiP04 Cortex A15 family" if ARCH_MULTI_V7
+	select ARM_ERRATA_798181 if SMP
 	select HAVE_ARM_ARCH_TIMER
 	select MCPM if SMP
 	select MCPM_QUAD_CLUSTER if SMP
-- 
1.9.1
