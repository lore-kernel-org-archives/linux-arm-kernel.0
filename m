From: robh@kernel.org (Rob Herring)
Date: Wed,  5 Sep 2018 14:37:23 -0500
Subject: [PATCH 06/21] arm64: use for_each_of_cpu_node iterator
In-Reply-To: <20180905193738.19325-1-robh@kernel.org>
References: <20180905193738.19325-1-robh@kernel.org>
Message-ID: <20180905193738.19325-7-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the for_each_of_cpu_node iterator to iterate over cpu nodes. This
has the side effect of defaulting to iterating using "cpu" node names in
preference to the deprecated (for FDT) device_type == "cpu".

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack and I will take via the DT tree. This is dependent on the
first 2 patches.

 arch/arm64/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 25fcd22a4bb2..96b8f2f51ab2 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -602,7 +602,7 @@ static void __init of_parse_and_init_cpus(void)
 {
 	struct device_node *dn;

-	for_each_node_by_type(dn, "cpu") {
+	for_each_of_cpu_node(dn) {
 		u64 hwid = of_get_cpu_mpidr(dn);

 		if (hwid == INVALID_HWID)
--
2.17.1
