From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 15 Sep 2017 18:02:14 +0200
Subject: [PATCH 2/2] [media] c8sectpfe: Improve two size determinations in
 c8sectpfe_frontend_attach()
In-Reply-To: <3e5fcfbe-828a-8c15-12d4-c74e8a1f20f1@users.sourceforge.net>
References: <3e5fcfbe-828a-8c15-12d4-c74e8a1f20f1@users.sourceforge.net>
Message-ID: <432261cc-ecf1-0673-b8e2-9ca317ceb772@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 15 Sep 2017 17:30:38 +0200

Replace the specification of data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/media/platform/sti/c8sectpfe/c8sectpfe-dvb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-dvb.c b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-dvb.c
index 1b23b188cd65..c3b09a9e30ec 100644
--- a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-dvb.c
+++ b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-dvb.c
@@ -164,12 +164,10 @@ int c8sectpfe_frontend_attach(struct dvb_frontend **fe,
 		tda18212 = devm_kzalloc(c8sectpfe->device,
-					sizeof(struct tda18212_config),
+					sizeof(*tda18212),
 					GFP_KERNEL);
 		if (!tda18212)
 			return -ENOMEM;
 
-		memcpy(tda18212, &tda18212_conf,
-			sizeof(struct tda18212_config));
-
+		memcpy(tda18212, &tda18212_conf, sizeof(*tda18212));
 		tda18212->fe = (*fe);
 
 		tda18212_info.platform_data = tda18212;
-- 
2.14.1
