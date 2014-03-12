From: maxime.coquelin@st.com (Maxime COQUELIN)
Date: Wed, 12 Mar 2014 09:50:08 +0100
Subject: [PATCH v4 4/6] pinctrl: st: Use ARRAY_SIZE instead of raw value for
 number of delays
In-Reply-To: <1394614210-15698-1-git-send-email-maxime.coquelin@st.com>
References: <1394614210-15698-1-git-send-email-maxime.coquelin@st.com>
Message-ID: <1394614210-15698-5-git-send-email-maxime.coquelin@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replaces the raw values with ARRAY_SIZE for assigning the
ninput_delays and noutput_delays fields of STiH416's st_pctl_data struct.

CC: Lee Jones <lee.jones@linaro.org>
Acked-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 drivers/pinctrl/pinctrl-st.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index 39cddaa..e4c4799 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -384,9 +384,9 @@ static unsigned int stih416_delays[] = {0, 300, 500, 750, 1000, 1250, 1500,
 static const struct st_pctl_data  stih416_data = {
 	.rt_style	= st_retime_style_dedicated,
 	.input_delays	= stih416_delays,
-	.ninput_delays	= 14,
+	.ninput_delays	= ARRAY_SIZE(stih416_delays),
 	.output_delays	= stih416_delays,
-	.noutput_delays = 14,
+	.noutput_delays = ARRAY_SIZE(stih416_delays),
 	.alt = 0, .oe = 40, .pu = 50, .od = 60, .rt = 100,
 };
 
-- 
1.9.0
