From: s-anna@ti.com (Suman Anna)
Date: Wed, 7 Jan 2015 11:30:54 -0600
Subject: [RFC PATCH 3/3] of/unittest: fix trailing semi-colons on conditional
 selftest
In-Reply-To: <1420651854-17768-1-git-send-email-s-anna@ti.com>
References: <1420651854-17768-1-git-send-email-s-anna@ti.com>
Message-ID: <1420651854-17768-4-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The of_platform_populate() and of_platform_depopulate() tests
are not really being tested because of some additional trailing
semi-colons after the conditional checks on couple of selftest
macro usage. Remove them to properly run all the platform
tests.

Fixes: 851da976dc1d (of/unittest: Remove test devices after adding them)
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/of/unittest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 844838e11ef1..c67e50264e82 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -765,11 +765,11 @@ static void __init of_selftest_platform_populate(void)
 	selftest(irq < 0 && irq != -EPROBE_DEFER, "device parsing error failed - %d\n", irq);
 
 	if (selftest(np = of_find_node_by_path("/testcase-data/platform-tests"),
-		     "No testcase data in device tree\n"));
+		     "No testcase data in device tree\n"))
 		return;
 
 	if (selftest(!(rc = device_register(&test_bus)),
-		     "testbus registration failed; rc=%i\n", rc));
+		     "testbus registration failed; rc=%i\n", rc))
 		return;
 
 	for_each_child_of_node(np, child) {
-- 
2.2.1
