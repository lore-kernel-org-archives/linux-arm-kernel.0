From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 30 Nov 2010 10:02:01 -0200
Subject: [PATCH v2 2/2] ARM: mx5: dynamically allocate imx-keypad devices
In-Reply-To: <1291118521-11385-1-git-send-email-fabio.estevam@freescale.com>
References: <1291118521-11385-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1291118521-11385-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/plat-mxc/devices/platform-imx-keypad.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/devices/platform-imx-keypad.c b/arch/arm/plat-mxc/devices/platform-imx-keypad.c
index 40238f0..2636611 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-keypad.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-keypad.c
@@ -41,6 +41,11 @@ const struct imx_imx_keypad_data imx35_imx_keypad_data __initconst =
 	imx_imx_keypad_data_entry_single(MX35, SZ_16);
 #endif /* ifdef CONFIG_SOC_IMX35 */
 
+#ifdef CONFIG_SOC_IMX51
+const struct imx_imx_keypad_data imx51_imx_keypad_data __initconst =
+	imx_imx_keypad_data_entry_single(MX51, SZ_16);
+#endif /* ifdef CONFIG_SOC_IMX51 */
+
 struct platform_device *__init imx_add_imx_keypad(
 		const struct imx_imx_keypad_data *data,
 		const struct matrix_keymap_data *pdata)
-- 
1.6.0.4
