From: keescook@chromium.org (Kees Cook)
Date: Wed, 21 Feb 2018 10:18:22 -0800
Subject: [PATCH v2 2/2] arm64: cpufeature: Remove redundant "feature" in
 reports
In-Reply-To: <1519237102-46854-1-git-send-email-keescook@chromium.org>
References: <1519237102-46854-1-git-send-email-keescook@chromium.org>
Message-ID: <1519237102-46854-3-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The word "feature" is repeated in the CPU features reporting. This drops it
for improved readability.

Before (redundant "feature" word):

 SMP: Total of 4 processors activated.
 CPU features: detected feature: 32-bit EL0 Support
 CPU features: detected feature: Kernel page table isolation (KPTI)
 CPU features: emulated: Privileged Access Never (PAN) using TTBR0_EL1 switching
 CPU: All CPU(s) started at EL2

After:

 SMP: Total of 4 processors activated.
 CPU features: detected: 32-bit EL0 Support
 CPU features: detected: Kernel page table isolation (KPTI)
 CPU features: emulated: Privileged Access Never (PAN) using TTBR0_EL1 switching
 CPU: All CPU(s) started at EL2

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 61aff55245ea..6c799ca58b53 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1357,7 +1357,7 @@ void check_local_cpu_capabilities(void)
 
 static void __init setup_feature_capabilities(void)
 {
-	update_cpu_capabilities(arm64_features, "detected feature:");
+	update_cpu_capabilities(arm64_features, "detected:");
 	enable_cpu_capabilities(arm64_features);
 }
 
-- 
2.7.4
