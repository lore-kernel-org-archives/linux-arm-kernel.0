From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed,  5 Apr 2017 02:45:16 +0800
Subject: [PATCH 1/3] phy: sun4i-usb: enable PHY0 dual route switching for A64
 USB PHY
Message-ID: <20170404184518.33610-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A64 SoC features a switchable PHY0 like the one in H3, which
can switch between a MUSB controller and a pair of OHCI/EHCI controller.

Enable PHY0 route auto switching for A64.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/phy/phy-sun4i-usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
index f86a2574b953..bbf06cfe5898 100644
--- a/drivers/phy/phy-sun4i-usb.c
+++ b/drivers/phy/phy-sun4i-usb.c
@@ -858,6 +858,7 @@ static const struct sun4i_usb_phy_cfg sun50i_a64_cfg = {
 	.phyctl_offset = REG_PHYCTL_A33,
 	.dedicated_clocks = true,
 	.enable_pmu_unk1 = true,
+	.phy0_dual_route = true,
 };
 
 static const struct of_device_id sun4i_usb_phy_of_match[] = {
-- 
2.12.2
