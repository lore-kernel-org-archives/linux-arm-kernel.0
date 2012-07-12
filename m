From: b29396@freescale.com (Dong Aisheng)
Date: Thu, 12 Jul 2012 19:38:44 +0800
Subject: [PATCH v3 2/2] pinctrl: pinctrl-imx6q: add missed mux function for
 USBOTG_ID
In-Reply-To: <1342093124-24658-1-git-send-email-b29396@freescale.com>
References: <1342093124-24658-1-git-send-email-b29396@freescale.com>
Message-ID: <1342093124-24658-2-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

The original pin registers table is derived from u-boot mainline,
but somehow it was found missing some mux functions for USBOTG_ID.
We added it at the bottom by following the exist pin function ids,
then it will not break the exist using of pin function id in dts file.

Reported-by: Richard Zhao <richard.zhao@freescale.com>
Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
ChangeLog v1->v2: No changes
---
 .../bindings/pinctrl/fsl,imx6q-pinctrl.txt         |    2 ++
 drivers/pinctrl/pinctrl-imx6q.c                    |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx6q-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx6q-pinctrl.txt
index 82b43f9..a4119f6 100644
--- a/Documentation/devicetree/bindings/pinctrl/fsl,imx6q-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx6q-pinctrl.txt
@@ -1626,3 +1626,5 @@ MX6Q_PAD_SD2_DAT3__PCIE_CTRL_MUX_11		1587
 MX6Q_PAD_SD2_DAT3__GPIO_1_12			1588
 MX6Q_PAD_SD2_DAT3__SJC_DONE			1589
 MX6Q_PAD_SD2_DAT3__ANATOP_TESTO_3		1590
+MX6Q_PAD_ENET_RX_ER__ANATOP_USBOTG_ID		1591
+MX6Q_PAD_GPIO_1__ANATOP_USBOTG_ID		1592
diff --git a/drivers/pinctrl/pinctrl-imx6q.c b/drivers/pinctrl/pinctrl-imx6q.c
index 6974238..4d9bc07 100644
--- a/drivers/pinctrl/pinctrl-imx6q.c
+++ b/drivers/pinctrl/pinctrl-imx6q.c
@@ -1950,6 +1950,8 @@ static struct imx_pin_reg imx6q_pin_regs[] = {
 	IMX_PIN_REG(MX6Q_PAD_SD2_DAT3, 0x0744, 0x035C, 5, 0x0000, 0), /* MX6Q_PAD_SD2_DAT3__GPIO_1_12 */
 	IMX_PIN_REG(MX6Q_PAD_SD2_DAT3, 0x0744, 0x035C, 6, 0x0000, 0), /* MX6Q_PAD_SD2_DAT3__SJC_DONE */
 	IMX_PIN_REG(MX6Q_PAD_SD2_DAT3, 0x0744, 0x035C, 7, 0x0000, 0), /* MX6Q_PAD_SD2_DAT3__ANATOP_TESTO_3 */
+	IMX_PIN_REG(MX6Q_PAD_ENET_RX_ER, 0x04EC, 0x01D8, 0, 0x0000, 0), /* MX6Q_PAD_ENET_RX_ER__ANATOP_USBOTG_ID */
+	IMX_PIN_REG(MX6Q_PAD_GPIO_1, 0x05F4, 0x0224, 3, 0x0000, 0), /* MX6Q_PAD_GPIO_1__ANATOP_USBOTG_ID */
 };
 
 /* Pad names for the pinmux subsystem */
-- 
1.7.0.4
