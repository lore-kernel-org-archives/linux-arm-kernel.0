From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Mon, 20 Mar 2017 00:19:46 +0800
Subject: [PATCH v4 3/8] phy: sun4i-usb: add PHYCTL offset for H3 SoC
In-Reply-To: <20170319161951.55834-1-icenowy@aosc.xyz>
References: <20170319161951.55834-1-icenowy@aosc.xyz>
Message-ID: <20170319161951.55834-4-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The config structure of H3 in phy-sun4i-usb driver have the PHYCTL
register offset missing.

Add it. Because it's a SoC after A33, its PHYCTL offset should be 0x10.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
New patch in v4.

 drivers/phy/phy-sun4i-usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
index 62b4d25448c6..a650f283f6ff 100644
--- a/drivers/phy/phy-sun4i-usb.c
+++ b/drivers/phy/phy-sun4i-usb.c
@@ -821,6 +821,7 @@ static const struct sun4i_usb_phy_cfg sun8i_h3_cfg = {
 	.num_phys = 4,
 	.type = sun8i_h3_phy,
 	.disc_thresh = 3,
+	.phyctl_offset = REG_PHYCTL_A33,
 	.dedicated_clocks = true,
 	.enable_pmu_unk1 = true,
 };
-- 
2.12.0
