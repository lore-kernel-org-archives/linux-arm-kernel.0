From: jglauber@cavium.com (Jan Glauber)
Date: Thu, 18 Feb 2016 17:50:14 +0100
Subject: [PATCH v4 5/5] arm64/perf: Extend event mask for ARMv8.1
In-Reply-To: <cover.1455810755.git.jglauber@cavium.com>
References: <cover.1455810755.git.jglauber@cavium.com>
Message-ID: <028b5d83ded39048ec996fe4d4912702704f156b.1455810755.git.jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv8.1 increases the PMU event number space to 16 bit so increase
the EVTYPE mask.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 arch/arm64/kernel/perf_event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index c68fa98..8746781 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -419,8 +419,8 @@ static const struct attribute_group *armv8_pmuv3_attr_groups[] = {
 /*
  * PMXEVTYPER: Event selection reg
  */
-#define	ARMV8_EVTYPE_MASK	0xc80003ff	/* Mask for writable bits */
-#define	ARMV8_EVTYPE_EVENT	0x3ff		/* Mask for EVENT bits */
+#define	ARMV8_EVTYPE_MASK	0xc800ffff	/* Mask for writable bits */
+#define	ARMV8_EVTYPE_EVENT	0xffff		/* Mask for EVENT bits */
 
 /*
  * Event filters for PMUv3
-- 
1.9.1
