From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  4 Aug 2014 10:16:54 +0200
Subject: [PATCH 1/3] arm64: fix typo in I-cache policy detection
Message-ID: <1407140216-22747-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes an unfortunately placed semi-colon resulting in all instruction
caches being classified as AIVIVT.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/cpuinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index f82f7d1c468e..744fad2ff418 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -49,7 +49,7 @@ static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info)
 
 	if (l1ip != ICACHE_POLICY_PIPT)
 		set_bit(ICACHEF_ALIASING, &__icache_flags);
-	if (l1ip == ICACHE_POLICY_AIVIVT);
+	if (l1ip == ICACHE_POLICY_AIVIVT)
 		set_bit(ICACHEF_AIVIVT, &__icache_flags);
 
 	pr_info("Detected %s I-cache on CPU%d", icache_policy_str[l1ip], cpu);
-- 
1.8.3.2
