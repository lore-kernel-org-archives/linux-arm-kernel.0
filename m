From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 30 Nov 2010 15:26:14 -0200
Subject: [PATCH v3 1/2] ARM: mx5: dynamically allocate pwm devices
Message-ID: <1291137975-9069-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/plat-mxc/devices/platform-mxc_pwm.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/devices/platform-mxc_pwm.c b/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
index 3d8ebdb..a5e1581 100644
--- a/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
+++ b/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
@@ -40,6 +40,15 @@ const struct imx_mxc_pwm_data imx27_mxc_pwm_data __initconst =
 	imx_mxc_pwm_data_entry_single(MX27, 0, , SZ_4K);
 #endif /* ifdef CONFIG_SOC_IMX27 */
 
+#ifdef CONFIG_SOC_IMX51
+const struct imx_mxc_pwm_data imx51_mxc_pwm_data[] __initconst = {
+#define imx51_mxc_pwm_data_entry(_id, _hwid)				\
+	imx_mxc_pwm_data_entry(MX51, _id, _hwid, SZ_16K)
+	imx51_mxc_pwm_data_entry(0, 1),
+	imx51_mxc_pwm_data_entry(1, 2),
+};
+#endif /* ifdef CONFIG_SOC_IMX51 */
+
 struct platform_device *__init imx_add_mxc_pwm(
 		const struct imx_mxc_pwm_data *data)
 {
-- 
1.6.0.4
