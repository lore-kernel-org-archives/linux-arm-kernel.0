From: xobs@kosagi.com (Sean Cross)
Date: Thu,  7 Mar 2013 06:00:10 +0000
Subject: [PATCH v2 3/3] ARM: dts: imx6q: Add pinctrl for audmix on AUD3
In-Reply-To: <1362636010-17367-1-git-send-email-xobs@kosagi.com>
References: <1362636010-17367-1-git-send-email-xobs@kosagi.com>
Message-ID: <1362636010-17367-4-git-send-email-xobs@kosagi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow AUD3 to be used as audio output from the audmux block.
---
 arch/arm/boot/dts/imx6q.dtsip |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q.dtsip b/arch/arm/boot/dts/imx6q.dtsip
index 1b1f80b..dbc4b46 100644
--- a/arch/arm/boot/dts/imx6q.dtsip
+++ b/arch/arm/boot/dts/imx6q.dtsip
@@ -85,6 +85,15 @@
 							MX6Q_PAD_SD2_DAT1__AUDMUX_AUD4_TXFS 0x80000000
 						>;
 					};
+
+					pinctrl_audmux_2: audmux-2 {
+						fsl,pins = <
+							MX6Q_PAD_CSI0_DAT7__AUDMUX_AUD3_RXD  0x80000000
+							MX6Q_PAD_CSI0_DAT4__AUDMUX_AUD3_TXC  0x80000000
+							MX6Q_PAD_CSI0_DAT5__AUDMUX_AUD3_TXD  0x80000000
+							MX6Q_PAD_CSI0_DAT6__AUDMUX_AUD3_TXFS 0x80000000
+						>;
+					};
 				};
 
 				ecspi1 {
-- 
1.7.9.5
