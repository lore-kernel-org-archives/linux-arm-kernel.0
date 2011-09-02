From: ajaykumar.rs@samsung.com (Ajay Kumar)
Date: Fri, 02 Sep 2011 19:32:21 +0530
Subject: [PATCH] ARM: S5P64X0: Fix mask value for S5P64X0 CPU IDs
Message-ID: <1314972141-14387-1-git-send-email-ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current value for S5P64XX_CPU_MASK does not include the necessary
bits, which causes detection failure.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
---
 arch/arm/plat-samsung/include/plat/cpu.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index aa1f69b..897d161 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -30,7 +30,7 @@ extern unsigned long samsung_cpu_id;
 
 #define S5P6440_CPU_ID		0x56440000
 #define S5P6450_CPU_ID		0x36450000
-#define S5P64XX_CPU_MASK	0x1FF40000
+#define S5P64XX_CPU_MASK	0x7FFF0000
 
 #define S5PC100_CPU_ID		0x43100000
 #define S5PC100_CPU_MASK	0xFFFFF000
-- 
1.7.2.3
