From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Wed, 27 Jan 2016 12:27:41 +0800
Subject: [PATCH 04/15] arc: use of_platform_default_populate() to populate
 default bus
In-Reply-To: <1453868872-26300-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1453868872-26300-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1453868872-26300-5-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use helper of_platform_default_populate() in linux/of_platform
when possible, instead of calling of_platform_populate() with
the default match table.

Cc: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arc/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index e1b8744..7134973 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -438,7 +438,7 @@ static int __init customize_machine(void)
 	 * Traverses flattened DeviceTree - registering platform devices
 	 * (if any) complete with their resources
 	 */
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_default_populate(NULL, NULL, NULL);
 
 	if (machine_desc->init_machine)
 		machine_desc->init_machine();
-- 
2.6.0.GIT
