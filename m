From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue,  5 Aug 2014 11:25:55 +0200
Subject: [PATCH v2 1/3] arm64: fix typo in I-cache policy detection
Message-ID: <1407230757-15305-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes an unfortunately placed semi-colon resulting in all instruction
caches being classified as AIVIVT.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
v2: add ack

 arch/arm64/kernel/cpuinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index f798f66634af..177169623026 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -49,7 +49,7 @@ static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info)
 
 	if (l1ip != ICACHE_POLICY_PIPT)
 		set_bit(ICACHEF_ALIASING, &__icache_flags);
-	if (l1ip == ICACHE_POLICY_AIVIVT);
+	if (l1ip == ICACHE_POLICY_AIVIVT)
 		set_bit(ICACHEF_AIVIVT, &__icache_flags);
 
 	pr_info("Detected %s I-cache on CPU%d\n", icache_policy_str[l1ip], cpu);
-- 
1.8.3.2
