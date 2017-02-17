From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 17 Feb 2017 15:25:08 +0100
Subject: [PATCH] arm64: kernel: Update kerneldoc for cpu_suspend() rename
Message-ID: <1487341508-20148-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit af391b15f7b56ce1 ("arm64: kernel: rename __cpu_suspend to keep it
aligned with arm") renamed cpu_suspend() to arm_cpuidle_suspend(), but
forgot to update the kerneldoc header.

Fixes: af391b15f7b56ce1 ("arm64: kernel: rename __cpu_suspend to keep it aligned with arm")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/kernel/cpuidle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
index 75a0f8acef669ce5..fd691087dc9ad58f 100644
--- a/arch/arm64/kernel/cpuidle.c
+++ b/arch/arm64/kernel/cpuidle.c
@@ -30,7 +30,7 @@ int arm_cpuidle_init(unsigned int cpu)
 }
 
 /**
- * cpu_suspend() - function to enter a low-power idle state
+ * arm_cpuidle_suspend() - function to enter a low-power idle state
  * @arg: argument to pass to CPU suspend operations
  *
  * Return: 0 on success, -EOPNOTSUPP if CPU suspend hook not initialized, CPU
-- 
1.9.1
