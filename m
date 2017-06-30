From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Fri, 30 Jun 2017 17:00:20 +0530
Subject: [PATCH] arm64: cpuinfo: constify attribute_group structures.
Message-ID: <8be91a9f9295fcbe8ec9cdcfd7c2e0b7e0e58ec3.1498821973.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work with const
attribute_group. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 arch/arm64/kernel/cpuinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 68b1f36..f495ee5 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -227,7 +227,7 @@ static void c_stop(struct seq_file *m, void *v)
 	NULL
 };
 
-static struct attribute_group cpuregs_attr_group = {
+static const struct attribute_group cpuregs_attr_group = {
 	.attrs = cpuregs_id_attrs,
 	.name = "identification"
 };
-- 
1.9.1
