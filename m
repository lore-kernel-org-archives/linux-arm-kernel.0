From: chao.xie@marvell.com (Chao Xie)
Date: Mon, 13 May 2013 01:51:43 -0400
Subject: [PATCh V10 12/12] usb: mv_usb: remove the phy callbacks in pdata
In-Reply-To: <1368424303-10629-1-git-send-email-chao.xie@marvell.com>
References: <1368424303-10629-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1368424303-10629-13-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The phy initialization code will be done by phy driver.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 include/linux/platform_data/mv_usb.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/include/linux/platform_data/mv_usb.h b/include/linux/platform_data/mv_usb.h
index 98b7925..b4b5d6f 100644
--- a/include/linux/platform_data/mv_usb.h
+++ b/include/linux/platform_data/mv_usb.h
@@ -45,9 +45,6 @@ struct mv_usb_platform_data {
 	/* Force a_bus_req to be asserted */
 	 unsigned int    otg_force_a_bus_req:1;
 
-	int	(*phy_init)(void __iomem *regbase);
-	void	(*phy_deinit)(void __iomem *regbase);
 	int	(*set_vbus)(unsigned int vbus);
-	int     (*private_init)(void __iomem *opregs, void __iomem *phyregs);
 };
 #endif
-- 
1.7.4.1
