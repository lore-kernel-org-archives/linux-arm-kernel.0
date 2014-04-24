From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 24 Apr 2014 13:17:15 +0300
Subject: [PATCH 19/23] OMAPDSS: HDMI: support larger register offsets for
 OMAP5 HDMI core
In-Reply-To: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1398334639-14172-20-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Archit Taneja <archit@ti.com>

The HDMI core IP on OMAP5 has a wider address range for registers. The offsets
for the later registers can't fit into the u16 type currently used for hdmi
register read and write functions. Use u32 for offsets instead.

Signed-off-by: Archit Taneja <archit@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index d784b2cced9d..0e5979ef933c 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi.h
@@ -361,13 +361,13 @@ struct hdmi_core_data {
 	struct hdmi_core_infoframe_avi avi_cfg;
 };
 
-static inline void hdmi_write_reg(void __iomem *base_addr, const u16 idx,
+static inline void hdmi_write_reg(void __iomem *base_addr, const u32 idx,
 		u32 val)
 {
 	__raw_writel(val, base_addr + idx);
 }
 
-static inline u32 hdmi_read_reg(void __iomem *base_addr, const u16 idx)
+static inline u32 hdmi_read_reg(void __iomem *base_addr, const u32 idx)
 {
 	return __raw_readl(base_addr + idx);
 }
-- 
1.9.1
