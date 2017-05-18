From: frank.wang@rock-chips.com (Frank Wang)
Date: Thu, 18 May 2017 11:42:59 +0800
Subject: [PATCH 1/4] phy: rockchip-inno-usb2: add a delay after phy resume
In-Reply-To: <1495078982-2555-1-git-send-email-frank.wang@rock-chips.com>
References: <1495078982-2555-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <1495078982-2555-2-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: William Wu <william.wu@rock-chips.com>

When resume phy, it need about 1.5 ~ 2ms to wait for
utmi_clk which used for USB controller to become stable.

Signed-off-by: William Wu <william.wu@rock-chips.com>
Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 drivers/phy/phy-rockchip-inno-usb2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/phy-rockchip-inno-usb2.c b/drivers/phy/phy-rockchip-inno-usb2.c
index 8efe78a..f12dc8d 100644
--- a/drivers/phy/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/phy-rockchip-inno-usb2.c
@@ -463,6 +463,9 @@ static int rockchip_usb2phy_power_on(struct phy *phy)
 	if (ret)
 		return ret;
 
+	/* waiting for the utmi_clk to become stable */
+	usleep_range(1500, 2000);
+
 	rport->suspended = false;
 	return 0;
 }
-- 
2.0.0
