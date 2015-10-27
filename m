From: will.deacon@arm.com (Will Deacon)
Date: Tue, 27 Oct 2015 12:05:54 +0000
Subject: [PATCH 1/2] arm64: cpufeature: declare enable_cpu_capabilities as
 static
Message-ID: <1445947555-2109-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable_cpu_capabilities is only called from within cpufeature.c, so it
can be declared static.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index d0d607452e1d..504526fa8129 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -732,7 +732,7 @@ void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
  * Run through the enabled capabilities and enable() it on all active
  * CPUs
  */
-void enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
+static void enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
 {
 	int i;
 
-- 
2.1.4
