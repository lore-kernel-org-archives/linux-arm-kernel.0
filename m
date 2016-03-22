From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 22 Mar 2016 22:42:40 +0800
Subject: [PATCH 1/4] ARM: cpuidle: add const qualifier to cpuidle_ops member
 in structures
In-Reply-To: <1458657763-2561-1-git-send-email-jszhang@marvell.com>
References: <1458657763-2561-1-git-send-email-jszhang@marvell.com>
Message-ID: <1458657763-2561-2-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The core code does not modify smp_operations structures. To clarify it,
this patch adds 'const' qualifier to the 'ops' member of struct
of_cpuidle_method.

This change allows each arm cpuidle code to add 'const' qualifier to
its cpuidle_ops structure.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/include/asm/cpuidle.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/cpuidle.h
index 3848259..baefe1d 100644
--- a/arch/arm/include/asm/cpuidle.h
+++ b/arch/arm/include/asm/cpuidle.h
@@ -36,7 +36,7 @@ struct cpuidle_ops {
 
 struct of_cpuidle_method {
 	const char *method;
-	struct cpuidle_ops *ops;
+	const struct cpuidle_ops *ops;
 };
 
 #define CPUIDLE_METHOD_OF_DECLARE(name, _method, _ops)			\
-- 
2.8.0.rc3
