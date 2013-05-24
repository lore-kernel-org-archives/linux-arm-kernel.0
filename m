From: b32955@freescale.com (Huang Shijie)
Date: Fri, 24 May 2013 17:59:23 +0800
Subject: [PATCH v3 5/6] ARM: dts: imx6dl: add pinctrls for WEIM NOR
In-Reply-To: <1369389564-13181-1-git-send-email-b32955@freescale.com>
References: <1369389564-13181-1-git-send-email-b32955@freescale.com>
Message-ID: <1369389564-13181-6-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add two pinctrls for WEIM:
   one for the weim nor, another for the chipselect.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx6dl.dtsi |   60 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 4b13454..ddc8d61 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -183,6 +183,66 @@
 					};
 				};
 
+				weim {
+					pinctrl_weim_cs_0: weim_norgrp-1 {
+						fsl,pins = <
+							MX6DL_PAD_EIM_CS0__EIM_CS0_B   0xb0b1
+							>;
+					};
+
+					pinctrl_weim_nor_1: weim_norgrp-2 {
+						fsl,pins = <
+							MX6DL_PAD_EIM_OE__EIM_OE_B     0xb0b1
+							MX6DL_PAD_EIM_RW__EIM_RW       0xb0b1
+							MX6DL_PAD_EIM_WAIT__EIM_WAIT_B 0xb060
+
+							/* data */
+							MX6DL_PAD_EIM_D16__EIM_DATA16 0xb0b1
+							MX6DL_PAD_EIM_D17__EIM_DATA17 0xb0b1
+							MX6DL_PAD_EIM_D18__EIM_DATA18 0xb0b1
+							MX6DL_PAD_EIM_D19__EIM_DATA19 0xb0b1
+							MX6DL_PAD_EIM_D20__EIM_DATA20 0xb0b1
+							MX6DL_PAD_EIM_D21__EIM_DATA21 0xb0b1
+							MX6DL_PAD_EIM_D22__EIM_DATA22 0xb0b1
+							MX6DL_PAD_EIM_D23__EIM_DATA23 0xb0b1
+							MX6DL_PAD_EIM_D24__EIM_DATA24 0xb0b1
+							MX6DL_PAD_EIM_D25__EIM_DATA25 0xb0b1
+							MX6DL_PAD_EIM_D26__EIM_DATA26 0xb0b1
+							MX6DL_PAD_EIM_D27__EIM_DATA27 0xb0b1
+							MX6DL_PAD_EIM_D28__EIM_DATA28 0xb0b1
+							MX6DL_PAD_EIM_D29__EIM_DATA29 0xb0b1
+							MX6DL_PAD_EIM_D30__EIM_DATA30 0xb0b1
+							MX6DL_PAD_EIM_D31__EIM_DATA31 0xb0b1
+
+							/* address */
+							MX6DL_PAD_EIM_A23__EIM_ADDR23 0xb0b1
+							MX6DL_PAD_EIM_A22__EIM_ADDR22 0xb0b1
+							MX6DL_PAD_EIM_A21__EIM_ADDR21 0xb0b1
+							MX6DL_PAD_EIM_A20__EIM_ADDR20 0xb0b1
+							MX6DL_PAD_EIM_A19__EIM_ADDR19 0xb0b1
+							MX6DL_PAD_EIM_A18__EIM_ADDR18 0xb0b1
+							MX6DL_PAD_EIM_A17__EIM_ADDR17 0xb0b1
+							MX6DL_PAD_EIM_A16__EIM_ADDR16 0xb0b1
+							MX6DL_PAD_EIM_DA15__EIM_AD15  0xb0b1
+							MX6DL_PAD_EIM_DA14__EIM_AD14  0xb0b1
+							MX6DL_PAD_EIM_DA13__EIM_AD13  0xb0b1
+							MX6DL_PAD_EIM_DA12__EIM_AD12  0xb0b1
+							MX6DL_PAD_EIM_DA11__EIM_AD11  0xb0b1
+							MX6DL_PAD_EIM_DA10__EIM_AD10  0xb0b1
+							MX6DL_PAD_EIM_DA9__EIM_AD09   0xb0b1
+							MX6DL_PAD_EIM_DA8__EIM_AD08   0xb0b1
+							MX6DL_PAD_EIM_DA7__EIM_AD07   0xb0b1
+							MX6DL_PAD_EIM_DA6__EIM_AD06   0xb0b1
+							MX6DL_PAD_EIM_DA5__EIM_AD05   0xb0b1
+							MX6DL_PAD_EIM_DA4__EIM_AD04   0xb0b1
+							MX6DL_PAD_EIM_DA3__EIM_AD03   0xb0b1
+							MX6DL_PAD_EIM_DA2__EIM_AD02   0xb0b1
+							MX6DL_PAD_EIM_DA1__EIM_AD01   0xb0b1
+							MX6DL_PAD_EIM_DA0__EIM_AD00   0xb0b1
+						>;
+					};
+
+				};
 
 			};
 
-- 
1.7.1
