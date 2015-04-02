From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Apr 2015 10:21:20 +0100
Subject: [PATCH RFC v2 01/13] drm: imx/dw_hdmi: move phy comments
In-Reply-To: <20150402092050.GH24899@n2100.arm.linux.org.uk>
References: <20150402092050.GH24899@n2100.arm.linux.org.uk>
Message-ID: <E1YdbJQ-00084m-GC@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The phy comments in dw_hdmi.c applied to the iMX6 version.  Move these
comments to the iMX6 dw_hdmi-imx data along side the data.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/bridge/dw_hdmi.c  | 3 ---
 drivers/gpu/drm/imx/dw_hdmi-imx.c | 5 +++++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index 49cafb61d290..3494391e4199 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -834,11 +834,8 @@ static int hdmi_phy_configure(struct dw_hdmi *hdmi, unsigned char prep,
 		    phy_config[i].mpixelclock)
 			break;
 
-	/* RESISTANCE TERM 133Ohm Cfg */
 	hdmi_phy_i2c_write(hdmi, phy_config[i].term, 0x19);  /* TXTERM */
-	/* PREEMP Cgf 0.00 */
 	hdmi_phy_i2c_write(hdmi, phy_config[i].sym_ctr, 0x09); /* CKSYMTXCTRL */
-	/* TX/CK LVL 10 */
 	hdmi_phy_i2c_write(hdmi, phy_config[i].vlev_ctr, 0x0E); /* VLEVCTRL */
 
 	/* REMOVE CLK TERM */
diff --git a/drivers/gpu/drm/imx/dw_hdmi-imx.c b/drivers/gpu/drm/imx/dw_hdmi-imx.c
index 1032c07773e3..2b2368f50c39 100644
--- a/drivers/gpu/drm/imx/dw_hdmi-imx.c
+++ b/drivers/gpu/drm/imx/dw_hdmi-imx.c
@@ -73,6 +73,11 @@ static const struct dw_hdmi_curr_ctrl imx_cur_ctr[] = {
 	}
 };
 
+/*
+ * Resistance term 133Ohm Cfg
+ * PREEMP config 0.00
+ * TX/CK level 10
+ */
 static const struct dw_hdmi_phy_config imx_phy_config[] = {
 	/*pixelclk   symbol   term   vlev */
 	{ 148500000, 0x800d, 0x0005, 0x01ad},
-- 
1.8.3.1
