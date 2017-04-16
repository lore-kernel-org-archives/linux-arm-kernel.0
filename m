From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sun, 16 Apr 2017 22:26:53 +0200
Subject: [PATCH 03/29] arm64: Define Cortex-A73 MIDR
In-Reply-To: <1492374441-23336-1-git-send-email-daniel.lezcano@linaro.org>
References: <20170416202542.GV2078@mai>
 <1492374441-23336-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1492374441-23336-3-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

As we're about to introduce a new workaround that is specific to
Cortex-A73, let's define the coresponding MIDR.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/cputype.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index fc50271..0984d1b 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -80,6 +80,7 @@
 #define ARM_CPU_PART_FOUNDATION		0xD00
 #define ARM_CPU_PART_CORTEX_A57		0xD07
 #define ARM_CPU_PART_CORTEX_A53		0xD03
+#define ARM_CPU_PART_CORTEX_A73		0xD09
 
 #define APM_CPU_PART_POTENZA		0x000
 
@@ -92,6 +93,7 @@
 
 #define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
 #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
+#define MIDR_CORTEX_A73 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A73)
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
 #define MIDR_QCOM_FALKOR_V1 MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_FALKOR_V1)
-- 
2.7.4
