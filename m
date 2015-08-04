From: skarajga@visteon.com (Karajgaonkar, Saurabh (S.))
Date: Tue, 4 Aug 2015 09:10:35 +0000
Subject: [PATCH 5/9] usb: host: oxu210hp-hcd: Simplify return statement
In-Reply-To: <cover.1438678566.git.skarajga@visteon.com>
References: <cover.1438678566.git.skarajga@visteon.com>
Message-ID: <36c30f52509df9691c70ce6a2b2d0404d50681e9.1438678566.git.skarajga@visteon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Saurabh Karajgaonkar <skarajga@visteon.com>

Replace redundant variable use in return statement.

Signed-off-by: Saurabh Karajgaonkar <skarajga@visteon.com>
---
 drivers/usb/host/oxu210hp-hcd.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/usb/host/oxu210hp-hcd.c b/drivers/usb/host/oxu210hp-hcd.c
index 6352f54..fe3bd1c 100644
--- a/drivers/usb/host/oxu210hp-hcd.c
+++ b/drivers/usb/host/oxu210hp-hcd.c
@@ -2670,7 +2670,6 @@ static int oxu_hcd_init(struct usb_hcd *hcd)
 static int oxu_reset(struct usb_hcd *hcd)
 {
 	struct oxu_hcd *oxu = hcd_to_oxu(hcd);
-	int ret;
 
 	spin_lock_init(&oxu->mem_lock);
 	INIT_LIST_HEAD(&oxu->urb_list);
@@ -2696,11 +2695,7 @@ static int oxu_reset(struct usb_hcd *hcd)
 	oxu->hcs_params = readl(&oxu->caps->hcs_params);
 	oxu->sbrn = 0x20;
 
-	ret = oxu_hcd_init(hcd);
-	if (ret)
-		return ret;
-
-	return 0;
+	return oxu_hcd_init(hcd);
 }
 
 static int oxu_run(struct usb_hcd *hcd)
-- 
1.9.1
