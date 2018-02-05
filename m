From: timur@codeaurora.org (Timur Tabi)
Date: Mon,  5 Feb 2018 14:11:29 -0600
Subject: [PATCH 1/2] [for 4.14] arm64: Define cputype macros for Falkor CPU
In-Reply-To: <1517861490-19395-1-git-send-email-timur@codeaurora.org>
References: <1517861490-19395-1-git-send-email-timur@codeaurora.org>
Message-ID: <1517861490-19395-2-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shanker Donthineni <shankerd@codeaurora.org>

commit c622cc013cec upstream

Add cputype definition macros for Qualcomm Datacenter Technologies
Falkor CPU in cputype.h. It's unfortunate that the first revision
of the Falkor CPU used the wrong part number 0x800, got fixed in v2
chip with part number 0xC00, and would be used the same value for
future revisions.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/cputype.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 235e77d98261..cbf08d7cbf30 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -91,6 +91,7 @@
 #define BRCM_CPU_PART_VULCAN		0x516
 
 #define QCOM_CPU_PART_FALKOR_V1		0x800
+#define QCOM_CPU_PART_FALKOR		0xC00
 
 #define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
 #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
@@ -99,6 +100,7 @@
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
 #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
 #define MIDR_QCOM_FALKOR_V1 MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_FALKOR_V1)
+#define MIDR_QCOM_FALKOR MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_FALKOR)
 
 #ifndef __ASSEMBLY__
 
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
