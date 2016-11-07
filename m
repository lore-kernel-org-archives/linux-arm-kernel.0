From: wulf@rock-chips.com (William Wu)
Date: Mon,  7 Nov 2016 21:00:58 +0800
Subject: [PATCH] phy: rockchip-inno-usb2: correct 480MHz output clock stable
 time
Message-ID: <1478523658-9400-1-git-send-email-wulf@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We found that the system crashed due to 480MHz output clock of
USB2 PHY was unstable after clock had been enabled by gpu module.

Theoretically, 1 millisecond is a critical value for 480MHz
output clock stable time, so we try to change the delay time
to 1.2 millisecond to avoid this issue.

Signed-off-by: William Wu <wulf@rock-chips.com>
---
 drivers/phy/phy-rockchip-inno-usb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/phy-rockchip-inno-usb2.c b/drivers/phy/phy-rockchip-inno-usb2.c
index ecfd7d1..8f2d2b6 100644
--- a/drivers/phy/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/phy-rockchip-inno-usb2.c
@@ -267,7 +267,7 @@ static int rockchip_usb2phy_clk480m_enable(struct clk_hw *hw)
 			return ret;
 
 		/* waitting for the clk become stable */
-		mdelay(1);
+		udelay(1200);
 	}
 
 	return 0;
-- 
2.0.0
