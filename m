From: b42378@freescale.com (Nicolin Chen)
Date: Thu, 13 Jun 2013 19:50:59 +0800
Subject: [PATCH 4/9] ARM: dtsi: imx6dl: Add a pinctrl for AUDMUX
In-Reply-To: <cover.1371123426.git.b42378@freescale.com>
References: <cover.1371123426.git.b42378@freescale.com>
Message-ID: <61023162fb7819ac181d57ab071a82b22bd7e2b2.1371123426.git.b42378@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a pinctrl for AUDMUX used on imx6dl-sabresd.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 arch/arm/boot/dts/imx6dl.dtsi |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 06bd544..023ac83 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -35,6 +35,17 @@
 				compatible = "fsl,imx6dl-iomuxc";
 				reg = <0x020e0000 0x4000>;
 
+				audmux {
+					pinctrl_audmux_2: audmux-2 {
+						fsl,pins = <
+							MX6DL_PAD_CSI0_DAT7__AUD3_RXD  0x80000000
+							MX6DL_PAD_CSI0_DAT4__AUD3_TXC  0x80000000
+							MX6DL_PAD_CSI0_DAT5__AUD3_TXD  0x80000000
+							MX6DL_PAD_CSI0_DAT6__AUD3_TXFS 0x80000000
+						>;
+					};
+				};
+
 				ecspi1 {
 					pinctrl_ecspi1_1: ecspi1grp-1 {
 						fsl,pins = <
-- 
1.7.1
