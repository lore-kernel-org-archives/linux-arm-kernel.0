From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Fri, 11 Apr 2014 16:33:30 +0200
Subject: [PATCH v3 2/7] driver: reset: sti: add keyscan for stih415
In-Reply-To: <1397226820-5604-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1397226820-5604-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1397226820-5604-4-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Giuseppe CONDORELLI <giuseppe.condorelli@st.com>

Add keyscan reset on stih415 reset controller.

Signed-off-by: Giuseppe Condorelli <giuseppe.condorelli@st.com>
---
 drivers/reset/sti/reset-stih415.c                     | 1 +
 include/dt-bindings/reset-controller/stih415-resets.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/reset/sti/reset-stih415.c b/drivers/reset/sti/reset-stih415.c
index e6f6c41..c93fd26 100644
--- a/drivers/reset/sti/reset-stih415.c
+++ b/drivers/reset/sti/reset-stih415.c
@@ -73,6 +73,7 @@ static const struct syscfg_reset_channel_data stih415_softresets[] = {
 	[STIH415_USB0_SOFTRESET] = STIH415_SRST_REAR(SYSCFG_376, 9),
 	[STIH415_USB1_SOFTRESET] = STIH415_SRST_REAR(SYSCFG_376, 10),
 	[STIH415_USB2_SOFTRESET] = STIH415_SRST_REAR(SYSCFG_376, 11),
+	[STIH415_KEYSCAN_SOFTRESET] = STIH415_SRST_LPM(LPM_SYSCFG_1, 8),
 };
 
 static struct syscfg_reset_controller_data stih415_powerdown_controller = {
diff --git a/include/dt-bindings/reset-controller/stih415-resets.h b/include/dt-bindings/reset-controller/stih415-resets.h
index c2f8a66..c2329fe 100644
--- a/include/dt-bindings/reset-controller/stih415-resets.h
+++ b/include/dt-bindings/reset-controller/stih415-resets.h
@@ -22,5 +22,6 @@
 #define STIH415_USB0_SOFTRESET		3
 #define STIH415_USB1_SOFTRESET		4
 #define STIH415_USB2_SOFTRESET		5
+#define STIH415_KEYSCAN_SOFTRESET	6
 
 #endif /* _DT_BINDINGS_RESET_CONTROLLER_STIH415 */
-- 
1.9.1
