From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu,  7 Mar 2013 22:58:13 +0100
Subject: [PATCH 07/11] net/console: switch to pr_xxx
In-Reply-To: <1362693497-2964-1-git-send-email-plagnioj@jcrosoft.com>
References: <20130307215402.GA32347@game.jcrosoft.org>
 <1362693497-2964-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1362693497-2964-7-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 net/netconsole.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netconsole.c b/net/netconsole.c
index 7d0f3f4..8db8356 100644
--- a/net/netconsole.c
+++ b/net/netconsole.c
@@ -185,7 +185,7 @@ static int netconsole_init(void)
 
 	ret = console_register(cdev);
 	if (ret) {
-		printf("netconsole: registering failed with %s\n", strerror(-ret));
+		pr_err("netconsole: registering failed with %s\n", strerror(-ret));
 		kfree(priv);
 		return ret;
 	}
@@ -194,7 +194,7 @@ static int netconsole_init(void)
 	dev_add_param(&cdev->class_dev, "port", nc_port_set, NULL, 0);
 	dev_set_param(&cdev->class_dev, "port", "6666");
 
-	printf("registered netconsole as %s%d\n", cdev->class_dev.name, cdev->class_dev.id);
+	pr_info("registered netconsole as %s%d\n", cdev->class_dev.name, cdev->class_dev.id);
 
 	return 0;
 }
-- 
1.7.10.4
