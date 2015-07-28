From: r.baldyga@samsung.com (Robert Baldyga)
Date: Tue, 28 Jul 2015 07:20:01 +0200
Subject: [PATCH 4/7] usb: gadget: f_mass_storage: check quirk instead of UDC
 name
In-Reply-To: <1438060804-21706-1-git-send-email-r.baldyga@samsung.com>
References: <1438060804-21706-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1438060804-21706-5-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use generic mechanism to check if UDC controller supports stalling.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/function/f_mass_storage.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index 9e88e2b..a229194 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -2836,7 +2836,8 @@ int fsg_common_set_cdev(struct fsg_common *common,
 	 * halt bulk endpoints correctly.  If one of them is present,
 	 * disable stalls.
 	 */
-	common->can_stall = can_stall && !(gadget_is_at91(common->gadget));
+	common->can_stall = can_stall &&
+			gadget_is_stall_supported(common->gadget);
 
 	return 0;
 }
-- 
1.9.1
