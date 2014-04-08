From: maxime.coquelin@st.com (Maxime COQUELIN)
Date: Tue,  8 Apr 2014 17:21:49 +0200
Subject: [PATCH 2/2] pinctrl: st: Use ARRAY_SIZE for STiH415 data
In-Reply-To: <1396970509-28009-1-git-send-email-maxime.coquelin@st.com>
References: <1396970509-28009-1-git-send-email-maxime.coquelin@st.com>
Message-ID: <1396970509-28009-3-git-send-email-maxime.coquelin@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch completes the one that used ARRAY_SIZE for STiH407 and STiH416
for setting ninput_delays and noutput_delays fields.

Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 drivers/pinctrl/pinctrl-st.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index 868f10f..6e65cfd 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -348,9 +348,9 @@ static const unsigned int stih415_output_delays[] = {0, 1000, 2000, 3000};
 #define STIH415_PCTRL_COMMON_DATA				\
 	.rt_style	= st_retime_style_packed,		\
 	.input_delays	= stih415_input_delays,			\
-	.ninput_delays	= 4,					\
+	.ninput_delays	= ARRAY_SIZE(stih415_input_delays),	\
 	.output_delays = stih415_output_delays,			\
-	.noutput_delays = 4
+	.noutput_delays = ARRAY_SIZE(stih415_output_delays)
 
 static const struct st_pctl_data  stih415_sbc_data = {
 	STIH415_PCTRL_COMMON_DATA,
-- 
1.9.0
