From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 29 Sep 2017 16:23:03 +0800
Subject: [PATCH v3 11/14] drm/sun4i: hdmi: Add A31 specific DDC register
 definitions
In-Reply-To: <20170929082306.16193-1-wens@csie.org>
References: <20170929082306.16193-1-wens@csie.org>
Message-ID: <20170929082306.16193-12-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DDC block for the HDMI controller is different on the A31.

This patch adds the register definitions.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi.h b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
index b1124a8f9f05..da4ea9efc6fa 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
@@ -153,6 +153,37 @@
 
 #define SUN4I_HDMI_DDC_FIFO_SIZE	16
 
+/* A31 specific */
+#define SUN6I_HDMI_DDC_CTRL_REG		0x500
+#define SUN6I_HDMI_DDC_CTRL_RESET		BIT(31)
+#define SUN6I_HDMI_DDC_CTRL_START_CMD		BIT(27)
+#define SUN6I_HDMI_DDC_CTRL_SDA_ENABLE		BIT(6)
+#define SUN6I_HDMI_DDC_CTRL_SCL_ENABLE		BIT(4)
+#define SUN6I_HDMI_DDC_CTRL_ENABLE		BIT(0)
+
+#define SUN6I_HDMI_DDC_CMD_REG		0x508
+#define SUN6I_HDMI_DDC_CMD_BYTE_COUNT(count)	((count) << 16)
+/* command types in lower 3 bits are the same as sun4i */
+
+#define SUN6I_HDMI_DDC_ADDR_REG		0x50c
+#define SUN6I_HDMI_DDC_ADDR_SEGMENT(seg)	(((seg) & 0xff) << 24)
+#define SUN6I_HDMI_DDC_ADDR_EDDC(addr)		(((addr) & 0xff) << 16)
+#define SUN6I_HDMI_DDC_ADDR_OFFSET(off)		(((off) & 0xff) << 8)
+#define SUN6I_HDMI_DDC_ADDR_SLAVE(addr)		(((addr) & 0xff) << 1)
+
+#define SUN6I_HDMI_DDC_INT_STATUS_REG	0x514
+#define SUN6I_HDMI_DDC_INT_STATUS_TIMEOUT	BIT(8)
+/* lower 8 bits are the same as sun4i */
+
+#define SUN6I_HDMI_DDC_FIFO_CTRL_REG	0x518
+#define SUN6I_HDMI_DDC_FIFO_CTRL_CLEAR		BIT(15)
+/* lower 9 bits are the same as sun4i */
+
+#define SUN6I_HDMI_DDC_CLK_REG		0x520
+/* DDC CLK bit fields are the same, but the formula is not */
+
+#define SUN6I_HDMI_DDC_FIFO_DATA_REG	0x580
+
 enum sun4i_hdmi_pkt_type {
 	SUN4I_HDMI_PKT_AVI = 2,
 	SUN4I_HDMI_PKT_END = 15,
-- 
2.14.2
