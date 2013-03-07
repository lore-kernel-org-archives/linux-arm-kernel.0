From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu,  7 Mar 2013 22:58:14 +0100
Subject: [PATCH 08/11] startup: switch to pr_xxx
In-Reply-To: <1362693497-2964-1-git-send-email-plagnioj@jcrosoft.com>
References: <20130307215402.GA32347@game.jcrosoft.org>
 <1362693497-2964-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1362693497-2964-8-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 common/startup.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/common/startup.c b/common/startup.c
index e49cc4c..ff00ca7 100644
--- a/common/startup.c
+++ b/common/startup.c
@@ -120,7 +120,7 @@ void __noreturn start_barebox(void)
 		ret = envfs_load(default_environment_path, "/env", 0);
 
 		if (ret && IS_ENABLED(CONFIG_DEFAULT_ENVIRONMENT)) {
-			printf("no valid environment found on %s. "
+			pr_err("no valid environment found on %s. "
 				"Using default environment\n",
 				default_environment_path);
 			envfs_load("/dev/defaultenv", "/env", 0);
@@ -128,17 +128,17 @@ void __noreturn start_barebox(void)
 	}
 
 	if (IS_ENABLED(CONFIG_COMMAND_SUPPORT)) {
-		printf("running /env/bin/init...\n");
+		pr_info("running /env/bin/init...\n");
 
 		if (!stat("/env/bin/init", &s)) {
 			run_command("source /env/bin/init", 0);
 		} else {
-			printf("not found\n");
+			pr_err("/env/bin/init not found\n");
 		}
 	}
 
 	if (!barebox_main) {
-		printf("No main function! aborting.\n");
+		pr_err("No main function! aborting.\n");
 		hang();
 	}
 
-- 
1.7.10.4
