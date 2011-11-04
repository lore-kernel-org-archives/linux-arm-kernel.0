From: amit.kachhap@linaro.org (amit.kachhap at linaro.org)
Date: Fri,  4 Nov 2011 13:03:46 -0400
Subject: [PATCH 2/4] ARM: exynos4: remove useless churn in sleep.S
In-Reply-To: <1320426228-21746-1-git-send-email-amit.kachhap@linaro.org>
References: <1320426228-21746-1-git-send-email-amit.kachhap@linaro.org>
Message-ID: <1320426228-21746-3-git-send-email-amit.kachhap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

This patch cleans up sleep code in preparation for L2 resume code
and hotplug functions

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/mach-exynos4/sleep.S |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos4/sleep.S b/arch/arm/mach-exynos4/sleep.S
index 0984078..c19527b 100644
--- a/arch/arm/mach-exynos4/sleep.S
+++ b/arch/arm/mach-exynos4/sleep.S
@@ -27,8 +27,6 @@
 */
 
 #include <linux/linkage.h>
-#include <asm/assembler.h>
-#include <asm/memory.h>
 
 	.text
 
@@ -52,3 +50,4 @@
 
 ENTRY(s3c_cpu_resume)
 	b	cpu_resume
+ENDPROC(s3c_cpu_resume)
-- 
1.7.5.4
