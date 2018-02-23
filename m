From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 23 Feb 2018 13:09:21 -0800
Subject: [PATCH 2/4] ARM: add Broadcom Brahma-B53 main ID definition
In-Reply-To: <20180223210923.544-1-f.fainelli@gmail.com>
References: <20180223210923.544-1-f.fainelli@gmail.com>
Message-ID: <20180223210923.544-3-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Doug Berger <opendmb@gmail.com>

This commit allows a Broadcom Brahma-B53 core to be detected when executing
an arm architecture kernel in aarch32 state.

Signed-off-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/include/asm/cputype.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index e7632f536633..6d1c7b22faea 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -59,6 +59,7 @@
 	((mpidr >> (MPIDR_LEVEL_BITS * level)) & MPIDR_LEVEL_MASK)
 
 #define ARM_CPU_IMP_ARM			0x41
+#define ARM_CPU_IMP_BRCM		0x42
 #define ARM_CPU_IMP_DEC			0x44
 #define ARM_CPU_IMP_INTEL		0x69
 
@@ -76,6 +77,9 @@
 #define ARM_CPU_PART_CORTEX_A15		0x4100c0f0
 #define ARM_CPU_PART_MASK		0xff00fff0
 
+/* Broadcom implemented processors */
+#define ARM_CPU_PART_BRAHMA_B53		0x42001000
+
 /* DEC implemented cores */
 #define ARM_CPU_PART_SA1100		0x4400a110
 
-- 
2.14.1
