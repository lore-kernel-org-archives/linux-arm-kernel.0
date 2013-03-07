From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu,  7 Mar 2013 22:58:10 +0100
Subject: [PATCH 04/11] startup: switch to pr_xxx
In-Reply-To: <1362693497-2964-1-git-send-email-plagnioj@jcrosoft.com>
References: <20130307215402.GA32347@game.jcrosoft.org>
 <1362693497-2964-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1362693497-2964-4-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 common/startup.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/startup.c b/common/startup.c
index 52a8996..e49cc4c 100644
--- a/common/startup.c
+++ b/common/startup.c
@@ -105,14 +105,14 @@ void __noreturn start_barebox(void)
 
 	for (initcall = __barebox_initcalls_start;
 			initcall < __barebox_initcalls_end; initcall++) {
-		debug("initcall-> %pS\n", *initcall);
+		pr_debug("initcall-> %pS\n", *initcall);
 		result = (*initcall)();
 		if (result)
 			pr_err("initcall %pS failed: %s\n", *initcall,
 					strerror(-result));
 	}
 
-	debug("initcalls done\n");
+	pr_debug("initcalls done\n");
 
 	if (IS_ENABLED(CONFIG_ENV_HANDLING)) {
 		int ret;
-- 
1.7.10.4
