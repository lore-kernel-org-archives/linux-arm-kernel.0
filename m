From: karim.eshapa@gmail.com (Karim Eshapa)
Date: Sat, 29 Apr 2017 22:43:40 +0200
Subject: [PATCH] drivers:soc:fsl:qbman:qman.c: unsigned long jiffies value.
In-Reply-To: <1493495164-8658-1-git-send-email-karim.eshapa@gmail.com>
References: <1493495164-8658-1-git-send-email-karim.eshapa@gmail.com>
Message-ID: <1493498620-9975-1-git-send-email-karim.eshapa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

unsigned long jiffies value sorry for that.

Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
---
 drivers/soc/fsl/qbman/qman.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index e0df4d1..6e1a44a 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -1084,7 +1084,7 @@ static int drain_mr_fqrni(struct qm_portal *p)
 		 * entries well before the ring has been fully consumed, so
 		 * we're being *really* paranoid here.
 		 */
-		unsigned int udel_time = jiffies_to_usecs(10000);
+		unsigned long udel_time = jiffies_to_usecs(10000);
 
 		usleep_range(udel_time/2, udel_time);
 		msg = qm_mr_current(p);
-- 
2.7.4
