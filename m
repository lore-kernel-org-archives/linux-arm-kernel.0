From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 24 Mar 2015 18:52:30 +0100
Subject: [PATCH v2 4/4] ARM: s5pv210: move resume code to .text section
In-Reply-To: <1427219550-21636-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1427219550-21636-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1427219550-21636-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This code calls cpu_resume() using a straight branch (b), so
now that we have moved cpu_resume() back to .text, this should
be moved there as well.

Acked-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/mach-s5pv210/sleep.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-s5pv210/sleep.S b/arch/arm/mach-s5pv210/sleep.S
index 7c43ddd33ba8..dfbfc0f7f8b8 100644
--- a/arch/arm/mach-s5pv210/sleep.S
+++ b/arch/arm/mach-s5pv210/sleep.S
@@ -14,7 +14,7 @@
 
 #include <linux/linkage.h>
 
-	.data
+	.text
 	.align
 
 	/*
-- 
1.8.3.2
