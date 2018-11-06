From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue,  6 Nov 2018 15:57:36 +0100
Subject: [PATCH v2 3/4] dt-bindings: clk: meson-gxbb: Add Video clock bindings
In-Reply-To: <1541516257-16157-1-git-send-email-narmstrong@baylibre.com>
References: <1541516257-16157-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1541516257-16157-4-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the video clock bindings covering all the video graphics pipeline
and the HDMI controller.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/gxbb.h              | 26 ++++++++++++++++++++++++--
 include/dt-bindings/clock/gxbb-clkc.h | 18 ++++++++++++++++++
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
index 72bc077..b53584f 100644
--- a/drivers/clk/meson/gxbb.h
+++ b/drivers/clk/meson/gxbb.h
@@ -165,8 +165,30 @@
 #define CLKID_HDMI_PLL_OD2	  163
 #define CLKID_SYS_PLL_DCO	  164
 #define CLKID_GP0_PLL_DCO	  165
-
-#define NR_CLKS			  166
+#define CLKID_VID_PLL_SEL	  167
+#define CLKID_VID_PLL_DIV	  168
+#define CLKID_VCLK_SEL		  169
+#define CLKID_VCLK2_SEL		  170
+#define CLKID_VCLK_INPUT	  171
+#define CLKID_VCLK2_INPUT	  172
+#define CLKID_VCLK_DIV		  173
+#define CLKID_VCLK2_DIV		  174
+#define CLKID_VCLK_DIV2_EN	  177
+#define CLKID_VCLK_DIV4_EN	  178
+#define CLKID_VCLK_DIV6_EN	  179
+#define CLKID_VCLK_DIV12_EN	  180
+#define CLKID_VCLK2_DIV2_EN	  181
+#define CLKID_VCLK2_DIV4_EN	  182
+#define CLKID_VCLK2_DIV6_EN	  183
+#define CLKID_VCLK2_DIV12_EN	  184
+#define CLKID_CTS_ENCI_SEL	  195
+#define CLKID_CTS_ENCP_SEL	  196
+#define CLKID_CTS_VDAC_SEL	  197
+#define CLKID_HDMI_TX_SEL	  198
+#define CLKID_HDMI_SEL		  203
+#define CLKID_HDMI_DIV		  204
+
+#define NR_CLKS			  206
 
 /* include the CLKIDs that have been made part of the DT binding */
 #include <dt-bindings/clock/gxbb-clkc.h>
diff --git a/include/dt-bindings/clock/gxbb-clkc.h b/include/dt-bindings/clock/gxbb-clkc.h
index 3979d48c..db0763e 100644
--- a/include/dt-bindings/clock/gxbb-clkc.h
+++ b/include/dt-bindings/clock/gxbb-clkc.h
@@ -128,5 +128,23 @@
 #define CLKID_VDEC_1		153
 #define CLKID_VDEC_HEVC		156
 #define CLKID_GEN_CLK		159
+#define CLKID_VID_PLL		166
+#define CLKID_VCLK		175
+#define CLKID_VCLK2		176
+#define CLKID_VCLK_DIV1		185
+#define CLKID_VCLK_DIV2		186
+#define CLKID_VCLK_DIV4		187
+#define CLKID_VCLK_DIV6		188
+#define CLKID_VCLK_DIV12	189
+#define CLKID_VCLK2_DIV1	190
+#define CLKID_VCLK2_DIV2	191
+#define CLKID_VCLK2_DIV4	192
+#define CLKID_VCLK2_DIV6	193
+#define CLKID_VCLK2_DIV12	194
+#define CLKID_CTS_ENCI		199
+#define CLKID_CTS_ENCP		200
+#define CLKID_CTS_VDAC		201
+#define CLKID_HDMI_TX		202
+#define CLKID_HDMI		205
 
 #endif /* __GXBB_CLKC_H */
-- 
2.7.4
