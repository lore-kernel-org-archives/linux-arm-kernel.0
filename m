From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Wed, 30 Oct 2013 13:25:32 +0800
Subject: [PATCH -next] arm64: use for_each_node_by_type() macro
Message-ID: <CAPgLHd_aQROa0-vycghYz9A9Jx4MbC131C819xPHZg_hrTQC7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Use for_each_node_by_type() macro instead of open coding it.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm64/kernel/cpu_ops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
index aa0c9e7..37a4977 100644
--- a/arch/arm64/kernel/cpu_ops.c
+++ b/arch/arm64/kernel/cpu_ops.c
@@ -78,10 +78,10 @@ int __init cpu_read_ops(struct device_node *dn, int cpu)
 
 void __init cpu_read_bootcpu_ops(void)
 {
-	struct device_node *dn = NULL;
+	struct device_node *dn;
 	u64 mpidr = cpu_logical_map(0);
 
-	while ((dn = of_find_node_by_type(dn, "cpu"))) {
+	for_each_node_by_type(dn,  "cpu") {
 		u64 hwid;
 		const __be32 *prop;
 
