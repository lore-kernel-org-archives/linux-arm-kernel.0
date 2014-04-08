From: maxime.coquelin@st.com (Maxime COQUELIN)
Date: Tue,  8 Apr 2014 17:21:48 +0200
Subject: [PATCH 1/2] pinctrl: st: Use const qualifier when required
In-Reply-To: <1396970509-28009-1-git-send-email-maxime.coquelin@st.com>
References: <1396970509-28009-1-git-send-email-maxime.coquelin@st.com>
Message-ID: <1396970509-28009-2-git-send-email-maxime.coquelin@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds const qualifier where applicable.

CC: Linus Walleij <linus.walleij@linaro.com>
Reported-by: Joe Perches <joe@perches.com>

Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 drivers/pinctrl/pinctrl-st.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index bd725b0..868f10f 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -242,13 +242,13 @@ struct st_pio_control {
 };
 
 struct st_pctl_data {
-	enum st_retime_style rt_style;
-	unsigned int	*input_delays;
-	int		ninput_delays;
-	unsigned int	*output_delays;
-	int		noutput_delays;
+	const enum st_retime_style	rt_style;
+	const unsigned int		*input_delays;
+	const int			ninput_delays;
+	const unsigned int		*output_delays;
+	const int			noutput_delays;
 	/* register offset information */
-	int alt, oe, pu, od, rt;
+	const int alt, oe, pu, od, rt;
 };
 
 struct st_pinconf {
@@ -342,8 +342,8 @@ struct st_pinctrl {
 
 /* SOC specific data */
 /* STiH415 data */
-static unsigned int stih415_input_delays[] = {0, 500, 1000, 1500};
-static unsigned int stih415_output_delays[] = {0, 1000, 2000, 3000};
+static const unsigned int stih415_input_delays[] = {0, 500, 1000, 1500};
+static const unsigned int stih415_output_delays[] = {0, 1000, 2000, 3000};
 
 #define STIH415_PCTRL_COMMON_DATA				\
 	.rt_style	= st_retime_style_packed,		\
@@ -378,8 +378,8 @@ static const struct st_pctl_data  stih415_right_data = {
 };
 
 /* STiH416 data */
-static unsigned int stih416_delays[] = {0, 300, 500, 750, 1000, 1250, 1500,
-			1750, 2000, 2250, 2500, 2750, 3000, 3250 };
+static const unsigned int stih416_delays[] = {0, 300, 500, 750, 1000, 1250,
+			1500, 1750, 2000, 2250, 2500, 2750, 3000, 3250 };
 
 static const struct st_pctl_data  stih416_data = {
 	.rt_style	= st_retime_style_dedicated,
@@ -468,7 +468,7 @@ static void st_pctl_set_function(struct st_pio_control *pc,
 static unsigned long st_pinconf_delay_to_bit(unsigned int delay,
 	const struct st_pctl_data *data, unsigned long config)
 {
-	unsigned int *delay_times;
+	const unsigned int *delay_times;
 	int num_delay_times, i, closest_index = -1;
 	unsigned int closest_divergence = UINT_MAX;
 
@@ -501,7 +501,7 @@ static unsigned long st_pinconf_delay_to_bit(unsigned int delay,
 static unsigned long st_pinconf_bit_to_delay(unsigned int index,
 	const struct st_pctl_data *data, unsigned long output)
 {
-	unsigned int *delay_times;
+	const unsigned int *delay_times;
 	int num_delay_times;
 
 	if (output) {
-- 
1.9.0
