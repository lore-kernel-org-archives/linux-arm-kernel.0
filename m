From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 27 Oct 2012 14:47:47 +0530
Subject: [PATCH 2/9] pinctrl: SPEAr3xx: correct register space to configure pwm
In-Reply-To: <cover.1351329224.git.viresh.kumar@linaro.org>
References: <cover.1351329224.git.viresh.kumar@linaro.org>
Message-ID: <c93a7cffdf92e0bb0e4f4b78daec66218752fa7a.1351329224.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shiraz Hashim <shiraz.hashim@st.com>

To have pwm on pad no. 34 we also need to select between pwm and SD_LED
functions. Add this to pwm pin mux register configuration.

Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Vipin Kumar <vipin.kumar@st.com>
---
 drivers/pinctrl/spear/pinctrl-spear320.c | 4 ++++
 drivers/pinctrl/spear/pinctrl-spear3xx.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/pinctrl/spear/pinctrl-spear320.c b/drivers/pinctrl/spear/pinctrl-spear320.c
index 020b1e0..4fccf95 100644
--- a/drivers/pinctrl/spear/pinctrl-spear320.c
+++ b/drivers/pinctrl/spear/pinctrl-spear320.c
@@ -2240,6 +2240,10 @@ static struct spear_muxreg pwm2_pin_34_muxreg[] = {
 		.mask = PMX_SSP_CS_MASK,
 		.val = 0,
 	}, {
+		.reg = MODE_CONFIG_REG,
+		.mask = PMX_PWM_MASK,
+		.val = PMX_PWM_MASK,
+	}, {
 		.reg = IP_SEL_PAD_30_39_REG,
 		.mask = PMX_PL_34_MASK,
 		.val = PMX_PWM2_PL_34_VAL,
diff --git a/drivers/pinctrl/spear/pinctrl-spear3xx.h b/drivers/pinctrl/spear/pinctrl-spear3xx.h
index 31f4434..7860b36 100644
--- a/drivers/pinctrl/spear/pinctrl-spear3xx.h
+++ b/drivers/pinctrl/spear/pinctrl-spear3xx.h
@@ -15,6 +15,7 @@
 #include "pinctrl-spear.h"
 
 /* pad mux declarations */
+#define PMX_PWM_MASK		(1 << 16)
 #define PMX_FIRDA_MASK		(1 << 14)
 #define PMX_I2C_MASK		(1 << 13)
 #define PMX_SSP_CS_MASK		(1 << 12)
-- 
1.7.12.rc2.18.g61b472e
