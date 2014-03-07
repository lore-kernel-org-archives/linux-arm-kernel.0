From: maxime.coquelin@st.com (Maxime COQUELIN)
Date: Fri,  7 Mar 2014 15:40:49 +0100
Subject: [PATCH v3 3/5] pinctrl: st: add pinctrl support for the STiH407 SoC
In-Reply-To: <1394203251-25361-1-git-send-email-maxime.coquelin@st.com>
References: <1394203251-25361-1-git-send-email-maxime.coquelin@st.com>
Message-ID: <1394203251-25361-4-git-send-email-maxime.coquelin@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Giuseppe Cavallaro <peppe.cavallaro@st.com>

This patch adds the initial support for pinctrl based on H407 SoC.

Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
---
 drivers/pinctrl/pinctrl-st.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index 1721611..d1886b4 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -390,6 +390,19 @@ static const struct st_pctl_data  stih416_data = {
 	.alt = 0, .oe = 40, .pu = 50, .od = 60, .rt = 100,
 };
 
+static const struct st_pctl_data  stih407_flashdata = {
+	.rt_style	= st_retime_style_none,
+	.input_delays	= stih416_delays,
+	.ninput_delays	= 14,
+	.output_delays	= stih416_delays,
+	.noutput_delays = 14,
+	.alt = 0,
+	.oe = -1, /* Not Available */
+	.pu = -1, /* Not Available */
+	.od = 60,
+	.rt = 100,
+};
+
 /* Low level functions.. */
 static inline int st_gpio_bank(int gpio)
 {
@@ -1596,6 +1609,10 @@ static struct of_device_id st_pctl_of_match[] = {
 	{ .compatible = "st,stih416-rear-pinctrl", .data = &stih416_data},
 	{ .compatible = "st,stih416-fvdp-fe-pinctrl", .data = &stih416_data},
 	{ .compatible = "st,stih416-fvdp-lite-pinctrl", .data = &stih416_data},
+	{ .compatible = "st,stih407-sbc-pinctrl", .data = &stih416_data},
+	{ .compatible = "st,stih407-front-pinctrl", .data = &stih416_data},
+	{ .compatible = "st,stih407-rear-pinctrl", .data = &stih416_data},
+	{ .compatible = "st,stih407-flash-pinctrl", .data = &stih407_flashdata},
 	{ /* sentinel */ }
 };
 
-- 
1.9.0
