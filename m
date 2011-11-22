From: amit.kachhap@linaro.org (Amit Daniel Kachhap)
Date: Tue, 22 Nov 2011 15:05:28 +0530
Subject: [PATCH V3 2/6] ARM: s5p: remove useless churn in sleep.S
In-Reply-To: <1321954532-18724-1-git-send-email-amit.kachhap@linaro.org>
References: <1321954532-18724-1-git-send-email-amit.kachhap@linaro.org>
Message-ID: <1321954532-18724-3-git-send-email-amit.kachhap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch cleans up sleep code in preparation for L2 resume code
and hotplug functions

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
---
 arch/arm/plat-s5p/sleep.S |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-s5p/sleep.S b/arch/arm/plat-s5p/sleep.S
index 0fd591b..c371ba2 100644
--- a/arch/arm/plat-s5p/sleep.S
+++ b/arch/arm/plat-s5p/sleep.S
@@ -23,7 +23,6 @@
 */
 
 #include <linux/linkage.h>
-#include <asm/assembler.h>
 
 	.text
 
@@ -44,6 +43,9 @@
 	 * other way of restoring the stack pointer after sleep, and we
 	 * must not write to the code segment (code is read-only)
 	 */
+	.align
+	.data
 
 ENTRY(s3c_cpu_resume)
 	b	cpu_resume
+ENDPROC(s3c_cpu_resume)
-- 
1.7.1
