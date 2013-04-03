From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  3 Apr 2013 11:04:39 +0900
Subject: [PATCH 01/28] sh-pfc: Fix compiler warning when BUG()
In-Reply-To: <1364954706-14727-1-git-send-email-horms+renesas@verge.net.au>
References: <1364954706-14727-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364954706-14727-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The sh_pfc_phys_to_virt() function ends with a BUG() statement without a
return. When CONFIG_BUG isn't set the function will thus have no return
value. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index feef897..97e6ea3 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -72,6 +72,7 @@ static void __iomem *sh_pfc_phys_to_virt(struct sh_pfc *pfc,
 	}
 
 	BUG();
+	return NULL;
 }
 
 int sh_pfc_get_pin_index(struct sh_pfc *pfc, unsigned int pin)
-- 
1.7.10.4
