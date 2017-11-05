From: ileixe@gmail.com (Yang Yooseok)
Date: Sun,  5 Nov 2017 22:16:55 +0900
Subject: [PATCH] ARM: topology: Fix minor typo in comment
Message-ID: <20171105131655.2046-1-ileixe@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The middle efficiency should be an average of two efficiency values, so
the fomula in comment is modified.

Signed-off-by: Yang Yooseok <ileixe@gmail.com>
---
 arch/arm/kernel/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 24ac3cab411d..d8a4619c86b8 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -77,7 +77,7 @@ static bool cap_from_dt = true;
 /*
  * Iterate all CPUs' descriptor in DT and compute the efficiency
  * (as per table_efficiency). Also calculate a middle efficiency
- * as close as possible to  (max{eff_i} - min{eff_i}) / 2
+ * as close as possible to  (max{eff_i} + min{eff_i}) / 2
  * This is later used to scale the cpu_capacity field such that an
  * 'average' CPU is of middle capacity. Also see the comments near
  * table_efficiency[] and update_cpu_capacity().
-- 
2.13.1
