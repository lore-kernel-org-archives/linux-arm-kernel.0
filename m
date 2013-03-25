From: chao.xie@marvell.com (Chao Xie)
Date: Mon, 25 Mar 2013 03:06:57 -0400
Subject: [PATCH V2 6/6] usb: mv_usb: remove clock name from pdata
In-Reply-To: <1364195217-1226-1-git-send-email-chao.xie@marvell.com>
References: <1364195217-1226-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1364195217-1226-7-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using pdata to pass clock name is not correct.
Directly get clock from usb drivers.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 include/linux/platform_data/mv_usb.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/include/linux/platform_data/mv_usb.h b/include/linux/platform_data/mv_usb.h
index 944b01d..98b7925 100644
--- a/include/linux/platform_data/mv_usb.h
+++ b/include/linux/platform_data/mv_usb.h
@@ -34,8 +34,6 @@ struct mv_usb_addon_irq {
 };
 
 struct mv_usb_platform_data {
-	unsigned int		clknum;
-	char			**clkname;
 	struct mv_usb_addon_irq	*id;	/* Only valid for OTG. ID pin change*/
 	struct mv_usb_addon_irq	*vbus;	/* valid for OTG/UDC. VBUS change*/
 
-- 
1.7.4.1
