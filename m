From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Mon,  9 Mar 2015 18:03:45 +0000
Subject: [PATCH 2/2] of: unittest: Add options string testcase variants
In-Reply-To: <1425924225-22748-1-git-send-email-leif.lindholm@linaro.org>
References: <1425924225-22748-1-git-send-email-leif.lindholm@linaro.org>
Message-ID: <1425924225-22748-3-git-send-email-leif.lindholm@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Hurley <peter@hurleysoftware.com>

Add testcase variants with '/' in the options string to test for
scan beyond end path name terminated by ':'.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/of/unittest.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 0cf9a23..b2d7547 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -92,6 +92,11 @@ static void __init of_selftest_find_node_by_name(void)
 		 "option path test failed\n");
 	of_node_put(np);
 
+	np = of_find_node_opts_by_path("/testcase-data:test/option", &options);
+	selftest(np && !strcmp("test/option", options),
+		 "option path test, subcase #1 failed\n");
+	of_node_put(np);
+
 	np = of_find_node_opts_by_path("/testcase-data:testoption", NULL);
 	selftest(np, "NULL option path test failed\n");
 	of_node_put(np);
@@ -102,6 +107,12 @@ static void __init of_selftest_find_node_by_name(void)
 		 "option alias path test failed\n");
 	of_node_put(np);
 
+	np = of_find_node_opts_by_path("testcase-alias:test/alias/option",
+				       &options);
+	selftest(np && !strcmp("test/alias/option", options),
+		 "option alias path test, subcase #1 failed\n");
+	of_node_put(np);
+
 	np = of_find_node_opts_by_path("testcase-alias:testaliasoption", NULL);
 	selftest(np, "NULL option alias path test failed\n");
 	of_node_put(np);
-- 
2.1.4
