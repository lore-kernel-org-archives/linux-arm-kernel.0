From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 17 Feb 2015 14:42:37 +0100
Subject: [PATCH] ARM: STi: DT: Move reset controller constants into common
 location
Message-ID: <1424180557-15750-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By popular vote, the DT binding includes for reset controllers are located
in include/dt-bindings/reset/. Move the STi reset constants in there, too,
to avoid confusion.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 .../bindings/reset/st,sti-picophyreset.txt         |  2 +-
 .../devicetree/bindings/reset/st,sti-powerdown.txt |  4 +-
 .../devicetree/bindings/reset/st,sti-softreset.txt |  4 +-
 arch/arm/boot/dts/stih407-family.dtsi              |  2 +-
 arch/arm/boot/dts/stih415.dtsi                     |  2 +-
 arch/arm/boot/dts/stih416.dtsi                     |  2 +-
 drivers/reset/sti/reset-stih407.c                  |  2 +-
 drivers/reset/sti/reset-stih415.c                  |  2 +-
 drivers/reset/sti/reset-stih416.c                  |  2 +-
 .../dt-bindings/reset-controller/stih407-resets.h  | 61 ----------------------
 .../dt-bindings/reset-controller/stih415-resets.h  | 27 ----------
 .../dt-bindings/reset-controller/stih416-resets.h  | 51 ------------------
 include/dt-bindings/reset/stih407-resets.h         | 61 ++++++++++++++++++++++
 include/dt-bindings/reset/stih415-resets.h         | 27 ++++++++++
 include/dt-bindings/reset/stih416-resets.h         | 51 ++++++++++++++++++
 15 files changed, 150 insertions(+), 150 deletions(-)
 delete mode 100644 include/dt-bindings/reset-controller/stih407-resets.h
 delete mode 100644 include/dt-bindings/reset-controller/stih415-resets.h
 delete mode 100644 include/dt-bindings/reset-controller/stih416-resets.h
 create mode 100644 include/dt-bindings/reset/stih407-resets.h
 create mode 100644 include/dt-bindings/reset/stih415-resets.h
 create mode 100644 include/dt-bindings/reset/stih416-resets.h

diff --git a/Documentation/devicetree/bindings/reset/st,sti-picophyreset.txt b/Documentation/devicetree/bindings/reset/st,sti-picophyreset.txt
index 54ae9f7..9ca2776 100644
--- a/Documentation/devicetree/bindings/reset/st,sti-picophyreset.txt
+++ b/Documentation/devicetree/bindings/reset/st,sti-picophyreset.txt
@@ -39,4 +39,4 @@ Example:
 	};
 
 Macro definitions for the supported reset channels can be found in:
-include/dt-bindings/reset-controller/stih407-resets.h
+include/dt-bindings/reset/stih407-resets.h
diff --git a/Documentation/devicetree/bindings/reset/st,sti-powerdown.txt b/Documentation/devicetree/bindings/reset/st,sti-powerdown.txt
index 5ab26b7..1cfd21d 100644
--- a/Documentation/devicetree/bindings/reset/st,sti-powerdown.txt
+++ b/Documentation/devicetree/bindings/reset/st,sti-powerdown.txt
@@ -43,5 +43,5 @@ example:
 
 Macro definitions for the supported reset channels can be found in:
 
-include/dt-bindings/reset-controller/stih415-resets.h
-include/dt-bindings/reset-controller/stih416-resets.h
+include/dt-bindings/reset/stih415-resets.h
+include/dt-bindings/reset/stih416-resets.h
diff --git a/Documentation/devicetree/bindings/reset/st,sti-softreset.txt b/Documentation/devicetree/bindings/reset/st,sti-softreset.txt
index a8d3d3c..891a2fd 100644
--- a/Documentation/devicetree/bindings/reset/st,sti-softreset.txt
+++ b/Documentation/devicetree/bindings/reset/st,sti-softreset.txt
@@ -42,5 +42,5 @@ example:
 
 Macro definitions for the supported reset channels can be found in:
 
-include/dt-bindings/reset-controller/stih415-resets.h
-include/dt-bindings/reset-controller/stih416-resets.h
+include/dt-bindings/reset/stih415-resets.h
+include/dt-bindings/reset/stih416-resets.h
diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 3e31d32..ef71851 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -7,7 +7,7 @@
  * publishhed by the Free Software Foundation.
  */
 #include "stih407-pinctrl.dtsi"
-#include <dt-bindings/reset-controller/stih407-resets.h>
+#include <dt-bindings/reset/stih407-resets.h>
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
diff --git a/arch/arm/boot/dts/stih415.dtsi b/arch/arm/boot/dts/stih415.dtsi
index 9198c12..95fd0a5 100644
--- a/arch/arm/boot/dts/stih415.dtsi
+++ b/arch/arm/boot/dts/stih415.dtsi
@@ -10,7 +10,7 @@
 #include "stih415-clock.dtsi"
 #include "stih415-pinctrl.dtsi"
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/reset-controller/stih415-resets.h>
+#include <dt-bindings/reset/stih415-resets.h>
 / {
 
 	L2: cache-controller {
diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
index fad9073..03924a4 100644
--- a/arch/arm/boot/dts/stih416.dtsi
+++ b/arch/arm/boot/dts/stih416.dtsi
@@ -12,7 +12,7 @@
 
 #include <dt-bindings/phy/phy-miphy365x.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/reset-controller/stih416-resets.h>
+#include <dt-bindings/reset/stih416-resets.h>
 / {
 	L2: cache-controller {
 		compatible = "arm,pl310-cache";
diff --git a/drivers/reset/sti/reset-stih407.c b/drivers/reset/sti/reset-stih407.c
index d83db5d7..f7a6cb0 100644
--- a/drivers/reset/sti/reset-stih407.c
+++ b/drivers/reset/sti/reset-stih407.c
@@ -11,7 +11,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
-#include <dt-bindings/reset-controller/stih407-resets.h>
+#include <dt-bindings/reset/stih407-resets.h>
 #include "reset-syscfg.h"
 
 /* STiH407 Peripheral powerdown definitions. */
diff --git a/drivers/reset/sti/reset-stih415.c b/drivers/reset/sti/reset-stih415.c
index 8dad603..f7b49d5 100644
--- a/drivers/reset/sti/reset-stih415.c
+++ b/drivers/reset/sti/reset-stih415.c
@@ -13,7 +13,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
-#include <dt-bindings/reset-controller/stih415-resets.h>
+#include <dt-bindings/reset/stih415-resets.h>
 
 #include "reset-syscfg.h"
 
diff --git a/drivers/reset/sti/reset-stih416.c b/drivers/reset/sti/reset-stih416.c
index 79aed70..d65a82e 100644
--- a/drivers/reset/sti/reset-stih416.c
+++ b/drivers/reset/sti/reset-stih416.c
@@ -13,7 +13,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
-#include <dt-bindings/reset-controller/stih416-resets.h>
+#include <dt-bindings/reset/stih416-resets.h>
 
 #include "reset-syscfg.h"
 
diff --git a/include/dt-bindings/reset-controller/stih407-resets.h b/include/dt-bindings/reset-controller/stih407-resets.h
deleted file mode 100644
index 02d4328..0000000
--- a/include/dt-bindings/reset-controller/stih407-resets.h
+++ /dev/null
@@ -1,61 +0,0 @@
-/*
- * This header provides constants for the reset controller
- * based peripheral powerdown requests on the STMicroelectronics
- * STiH407 SoC.
- */
-#ifndef _DT_BINDINGS_RESET_CONTROLLER_STIH407
-#define _DT_BINDINGS_RESET_CONTROLLER_STIH407
-
-/* Powerdown requests control 0 */
-#define STIH407_EMISS_POWERDOWN		0
-#define STIH407_NAND_POWERDOWN		1
-
-/* Synp GMAC PowerDown */
-#define STIH407_ETH1_POWERDOWN		2
-
-/* Powerdown requests control 1 */
-#define STIH407_USB3_POWERDOWN		3
-#define STIH407_USB2_PORT1_POWERDOWN	4
-#define STIH407_USB2_PORT0_POWERDOWN	5
-#define STIH407_PCIE1_POWERDOWN		6
-#define STIH407_PCIE0_POWERDOWN		7
-#define STIH407_SATA1_POWERDOWN		8
-#define STIH407_SATA0_POWERDOWN		9
-
-/* Reset defines */
-#define STIH407_ETH1_SOFTRESET		0
-#define STIH407_MMC1_SOFTRESET		1
-#define STIH407_PICOPHY_SOFTRESET	2
-#define STIH407_IRB_SOFTRESET		3
-#define STIH407_PCIE0_SOFTRESET		4
-#define STIH407_PCIE1_SOFTRESET		5
-#define STIH407_SATA0_SOFTRESET		6
-#define STIH407_SATA1_SOFTRESET		7
-#define STIH407_MIPHY0_SOFTRESET	8
-#define STIH407_MIPHY1_SOFTRESET	9
-#define STIH407_MIPHY2_SOFTRESET	10
-#define STIH407_SATA0_PWR_SOFTRESET	11
-#define STIH407_SATA1_PWR_SOFTRESET	12
-#define STIH407_DELTA_SOFTRESET		13
-#define STIH407_BLITTER_SOFTRESET	14
-#define STIH407_HDTVOUT_SOFTRESET	15
-#define STIH407_HDQVDP_SOFTRESET	16
-#define STIH407_VDP_AUX_SOFTRESET	17
-#define STIH407_COMPO_SOFTRESET		18
-#define STIH407_HDMI_TX_PHY_SOFTRESET	19
-#define STIH407_JPEG_DEC_SOFTRESET	20
-#define STIH407_VP8_DEC_SOFTRESET	21
-#define STIH407_GPU_SOFTRESET		22
-#define STIH407_HVA_SOFTRESET		23
-#define STIH407_ERAM_HVA_SOFTRESET	24
-#define STIH407_LPM_SOFTRESET		25
-#define STIH407_KEYSCAN_SOFTRESET	26
-#define STIH407_USB2_PORT0_SOFTRESET	27
-#define STIH407_USB2_PORT1_SOFTRESET	28
-
-/* Picophy reset defines */
-#define STIH407_PICOPHY0_RESET		0
-#define STIH407_PICOPHY1_RESET		1
-#define STIH407_PICOPHY2_RESET		2
-
-#endif /* _DT_BINDINGS_RESET_CONTROLLER_STIH407 */
diff --git a/include/dt-bindings/reset-controller/stih415-resets.h b/include/dt-bindings/reset-controller/stih415-resets.h
deleted file mode 100644
index c2329fe..0000000
--- a/include/dt-bindings/reset-controller/stih415-resets.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * This header provides constants for the reset controller
- * based peripheral powerdown requests on the STMicroelectronics
- * STiH415 SoC.
- */
-#ifndef _DT_BINDINGS_RESET_CONTROLLER_STIH415
-#define _DT_BINDINGS_RESET_CONTROLLER_STIH415
-
-#define STIH415_EMISS_POWERDOWN		0
-#define STIH415_NAND_POWERDOWN		1
-#define STIH415_KEYSCAN_POWERDOWN	2
-#define STIH415_USB0_POWERDOWN		3
-#define STIH415_USB1_POWERDOWN		4
-#define STIH415_USB2_POWERDOWN		5
-#define STIH415_SATA0_POWERDOWN		6
-#define STIH415_SATA1_POWERDOWN		7
-#define STIH415_PCIE_POWERDOWN		8
-
-#define STIH415_ETH0_SOFTRESET		0
-#define STIH415_ETH1_SOFTRESET		1
-#define STIH415_IRB_SOFTRESET		2
-#define STIH415_USB0_SOFTRESET		3
-#define STIH415_USB1_SOFTRESET		4
-#define STIH415_USB2_SOFTRESET		5
-#define STIH415_KEYSCAN_SOFTRESET	6
-
-#endif /* _DT_BINDINGS_RESET_CONTROLLER_STIH415 */
diff --git a/include/dt-bindings/reset-controller/stih416-resets.h b/include/dt-bindings/reset-controller/stih416-resets.h
deleted file mode 100644
index fcf9af1..0000000
--- a/include/dt-bindings/reset-controller/stih416-resets.h
+++ /dev/null
@@ -1,51 +0,0 @@
-/*
- * This header provides constants for the reset controller
- * based peripheral powerdown requests on the STMicroelectronics
- * STiH416 SoC.
- */
-#ifndef _DT_BINDINGS_RESET_CONTROLLER_STIH416
-#define _DT_BINDINGS_RESET_CONTROLLER_STIH416
-
-#define STIH416_EMISS_POWERDOWN		0
-#define STIH416_NAND_POWERDOWN		1
-#define STIH416_KEYSCAN_POWERDOWN	2
-#define STIH416_USB0_POWERDOWN		3
-#define STIH416_USB1_POWERDOWN		4
-#define STIH416_USB2_POWERDOWN		5
-#define STIH416_USB3_POWERDOWN		6
-#define STIH416_SATA0_POWERDOWN		7
-#define STIH416_SATA1_POWERDOWN		8
-#define STIH416_PCIE0_POWERDOWN		9
-#define STIH416_PCIE1_POWERDOWN		10
-
-#define STIH416_ETH0_SOFTRESET		0
-#define STIH416_ETH1_SOFTRESET		1
-#define STIH416_IRB_SOFTRESET		2
-#define STIH416_USB0_SOFTRESET		3
-#define STIH416_USB1_SOFTRESET		4
-#define STIH416_USB2_SOFTRESET		5
-#define STIH416_USB3_SOFTRESET		6
-#define STIH416_SATA0_SOFTRESET		7
-#define STIH416_SATA1_SOFTRESET		8
-#define STIH416_PCIE0_SOFTRESET		9
-#define STIH416_PCIE1_SOFTRESET		10
-#define STIH416_AUD_DAC_SOFTRESET	11
-#define STIH416_HDTVOUT_SOFTRESET	12
-#define STIH416_VTAC_M_RX_SOFTRESET	13
-#define STIH416_VTAC_A_RX_SOFTRESET	14
-#define STIH416_SYNC_HD_SOFTRESET	15
-#define STIH416_SYNC_SD_SOFTRESET	16
-#define STIH416_BLITTER_SOFTRESET	17
-#define STIH416_GPU_SOFTRESET		18
-#define STIH416_VTAC_M_TX_SOFTRESET	19
-#define STIH416_VTAC_A_TX_SOFTRESET	20
-#define STIH416_VTG_AUX_SOFTRESET	21
-#define STIH416_JPEG_DEC_SOFTRESET	22
-#define STIH416_HVA_SOFTRESET		23
-#define STIH416_COMPO_M_SOFTRESET	24
-#define STIH416_COMPO_A_SOFTRESET	25
-#define STIH416_VP8_DEC_SOFTRESET	26
-#define STIH416_VTG_MAIN_SOFTRESET	27
-#define STIH416_KEYSCAN_SOFTRESET	28
-
-#endif /* _DT_BINDINGS_RESET_CONTROLLER_STIH416 */
diff --git a/include/dt-bindings/reset/stih407-resets.h b/include/dt-bindings/reset/stih407-resets.h
new file mode 100644
index 0000000..02d4328
--- /dev/null
+++ b/include/dt-bindings/reset/stih407-resets.h
@@ -0,0 +1,61 @@
+/*
+ * This header provides constants for the reset controller
+ * based peripheral powerdown requests on the STMicroelectronics
+ * STiH407 SoC.
+ */
+#ifndef _DT_BINDINGS_RESET_CONTROLLER_STIH407
+#define _DT_BINDINGS_RESET_CONTROLLER_STIH407
+
+/* Powerdown requests control 0 */
+#define STIH407_EMISS_POWERDOWN		0
+#define STIH407_NAND_POWERDOWN		1
+
+/* Synp GMAC PowerDown */
+#define STIH407_ETH1_POWERDOWN		2
+
+/* Powerdown requests control 1 */
+#define STIH407_USB3_POWERDOWN		3
+#define STIH407_USB2_PORT1_POWERDOWN	4
+#define STIH407_USB2_PORT0_POWERDOWN	5
+#define STIH407_PCIE1_POWERDOWN		6
+#define STIH407_PCIE0_POWERDOWN		7
+#define STIH407_SATA1_POWERDOWN		8
+#define STIH407_SATA0_POWERDOWN		9
+
+/* Reset defines */
+#define STIH407_ETH1_SOFTRESET		0
+#define STIH407_MMC1_SOFTRESET		1
+#define STIH407_PICOPHY_SOFTRESET	2
+#define STIH407_IRB_SOFTRESET		3
+#define STIH407_PCIE0_SOFTRESET		4
+#define STIH407_PCIE1_SOFTRESET		5
+#define STIH407_SATA0_SOFTRESET		6
+#define STIH407_SATA1_SOFTRESET		7
+#define STIH407_MIPHY0_SOFTRESET	8
+#define STIH407_MIPHY1_SOFTRESET	9
+#define STIH407_MIPHY2_SOFTRESET	10
+#define STIH407_SATA0_PWR_SOFTRESET	11
+#define STIH407_SATA1_PWR_SOFTRESET	12
+#define STIH407_DELTA_SOFTRESET		13
+#define STIH407_BLITTER_SOFTRESET	14
+#define STIH407_HDTVOUT_SOFTRESET	15
+#define STIH407_HDQVDP_SOFTRESET	16
+#define STIH407_VDP_AUX_SOFTRESET	17
+#define STIH407_COMPO_SOFTRESET		18
+#define STIH407_HDMI_TX_PHY_SOFTRESET	19
+#define STIH407_JPEG_DEC_SOFTRESET	20
+#define STIH407_VP8_DEC_SOFTRESET	21
+#define STIH407_GPU_SOFTRESET		22
+#define STIH407_HVA_SOFTRESET		23
+#define STIH407_ERAM_HVA_SOFTRESET	24
+#define STIH407_LPM_SOFTRESET		25
+#define STIH407_KEYSCAN_SOFTRESET	26
+#define STIH407_USB2_PORT0_SOFTRESET	27
+#define STIH407_USB2_PORT1_SOFTRESET	28
+
+/* Picophy reset defines */
+#define STIH407_PICOPHY0_RESET		0
+#define STIH407_PICOPHY1_RESET		1
+#define STIH407_PICOPHY2_RESET		2
+
+#endif /* _DT_BINDINGS_RESET_CONTROLLER_STIH407 */
diff --git a/include/dt-bindings/reset/stih415-resets.h b/include/dt-bindings/reset/stih415-resets.h
new file mode 100644
index 0000000..c2329fe
--- /dev/null
+++ b/include/dt-bindings/reset/stih415-resets.h
@@ -0,0 +1,27 @@
+/*
+ * This header provides constants for the reset controller
+ * based peripheral powerdown requests on the STMicroelectronics
+ * STiH415 SoC.
+ */
+#ifndef _DT_BINDINGS_RESET_CONTROLLER_STIH415
+#define _DT_BINDINGS_RESET_CONTROLLER_STIH415
+
+#define STIH415_EMISS_POWERDOWN		0
+#define STIH415_NAND_POWERDOWN		1
+#define STIH415_KEYSCAN_POWERDOWN	2
+#define STIH415_USB0_POWERDOWN		3
+#define STIH415_USB1_POWERDOWN		4
+#define STIH415_USB2_POWERDOWN		5
+#define STIH415_SATA0_POWERDOWN		6
+#define STIH415_SATA1_POWERDOWN		7
+#define STIH415_PCIE_POWERDOWN		8
+
+#define STIH415_ETH0_SOFTRESET		0
+#define STIH415_ETH1_SOFTRESET		1
+#define STIH415_IRB_SOFTRESET		2
+#define STIH415_USB0_SOFTRESET		3
+#define STIH415_USB1_SOFTRESET		4
+#define STIH415_USB2_SOFTRESET		5
+#define STIH415_KEYSCAN_SOFTRESET	6
+
+#endif /* _DT_BINDINGS_RESET_CONTROLLER_STIH415 */
diff --git a/include/dt-bindings/reset/stih416-resets.h b/include/dt-bindings/reset/stih416-resets.h
new file mode 100644
index 0000000..fcf9af1
--- /dev/null
+++ b/include/dt-bindings/reset/stih416-resets.h
@@ -0,0 +1,51 @@
+/*
+ * This header provides constants for the reset controller
+ * based peripheral powerdown requests on the STMicroelectronics
+ * STiH416 SoC.
+ */
+#ifndef _DT_BINDINGS_RESET_CONTROLLER_STIH416
+#define _DT_BINDINGS_RESET_CONTROLLER_STIH416
+
+#define STIH416_EMISS_POWERDOWN		0
+#define STIH416_NAND_POWERDOWN		1
+#define STIH416_KEYSCAN_POWERDOWN	2
+#define STIH416_USB0_POWERDOWN		3
+#define STIH416_USB1_POWERDOWN		4
+#define STIH416_USB2_POWERDOWN		5
+#define STIH416_USB3_POWERDOWN		6
+#define STIH416_SATA0_POWERDOWN		7
+#define STIH416_SATA1_POWERDOWN		8
+#define STIH416_PCIE0_POWERDOWN		9
+#define STIH416_PCIE1_POWERDOWN		10
+
+#define STIH416_ETH0_SOFTRESET		0
+#define STIH416_ETH1_SOFTRESET		1
+#define STIH416_IRB_SOFTRESET		2
+#define STIH416_USB0_SOFTRESET		3
+#define STIH416_USB1_SOFTRESET		4
+#define STIH416_USB2_SOFTRESET		5
+#define STIH416_USB3_SOFTRESET		6
+#define STIH416_SATA0_SOFTRESET		7
+#define STIH416_SATA1_SOFTRESET		8
+#define STIH416_PCIE0_SOFTRESET		9
+#define STIH416_PCIE1_SOFTRESET		10
+#define STIH416_AUD_DAC_SOFTRESET	11
+#define STIH416_HDTVOUT_SOFTRESET	12
+#define STIH416_VTAC_M_RX_SOFTRESET	13
+#define STIH416_VTAC_A_RX_SOFTRESET	14
+#define STIH416_SYNC_HD_SOFTRESET	15
+#define STIH416_SYNC_SD_SOFTRESET	16
+#define STIH416_BLITTER_SOFTRESET	17
+#define STIH416_GPU_SOFTRESET		18
+#define STIH416_VTAC_M_TX_SOFTRESET	19
+#define STIH416_VTAC_A_TX_SOFTRESET	20
+#define STIH416_VTG_AUX_SOFTRESET	21
+#define STIH416_JPEG_DEC_SOFTRESET	22
+#define STIH416_HVA_SOFTRESET		23
+#define STIH416_COMPO_M_SOFTRESET	24
+#define STIH416_COMPO_A_SOFTRESET	25
+#define STIH416_VP8_DEC_SOFTRESET	26
+#define STIH416_VTG_MAIN_SOFTRESET	27
+#define STIH416_KEYSCAN_SOFTRESET	28
+
+#endif /* _DT_BINDINGS_RESET_CONTROLLER_STIH416 */
-- 
2.1.4
