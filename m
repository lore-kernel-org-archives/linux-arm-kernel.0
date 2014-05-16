From: jean.pihet@linaro.org (Jean Pihet)
Date: Fri, 16 May 2014 10:41:09 +0200
Subject: [PATCH 1/4] tools: perf: consolidate types.h for ARM and ARM64
In-Reply-To: <CAFrcx1mkE-N+DYUe0ZK06_BL1tsZvmyMHpAynnFkgZBqjghE5Q@mail.gmail.com>
References: <CAFrcx1mkE-N+DYUe0ZK06_BL1tsZvmyMHpAynnFkgZBqjghE5Q@mail.gmail.com>
Message-ID: <1400229672-16104-1-git-send-email-jean.pihet@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prevents a build breakage since commit d944c4eebcf4c0d5e5d9728fec110cbf0047ad7f
'tools: Consolidate types.h'

Signed-off-by: Jean Pihet <jean.pihet@linaro.org>
---
 tools/perf/arch/arm/include/perf_regs.h   | 2 +-
 tools/perf/arch/arm64/include/perf_regs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/arm/include/perf_regs.h b/tools/perf/arch/arm/include/perf_regs.h
index 2a1cfde..bcca511 100644
--- a/tools/perf/arch/arm/include/perf_regs.h
+++ b/tools/perf/arch/arm/include/perf_regs.h
@@ -2,7 +2,7 @@
 #define ARCH_PERF_REGS_H
 
 #include <stdlib.h>
-#include "../../util/types.h"
+#include <linux/types.h>
 #include <asm/perf_regs.h>
 
 #define PERF_REGS_MASK	((1ULL << PERF_REG_ARM_MAX) - 1)
diff --git a/tools/perf/arch/arm64/include/perf_regs.h b/tools/perf/arch/arm64/include/perf_regs.h
index 2359546..e9441b9 100644
--- a/tools/perf/arch/arm64/include/perf_regs.h
+++ b/tools/perf/arch/arm64/include/perf_regs.h
@@ -2,7 +2,7 @@
 #define ARCH_PERF_REGS_H
 
 #include <stdlib.h>
-#include "../../util/types.h"
+#include <linux/types.h>
 #include <asm/perf_regs.h>
 
 #define PERF_REGS_MASK	((1ULL << PERF_REG_ARM64_MAX) - 1)
-- 
1.7.11.7
