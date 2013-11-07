From: shc_work@mail.ru (Alexander Shiyan)
Date: Thu,  7 Nov 2013 12:45:06 +0400
Subject: [PATCH 3/5] ARM: dts: i.MX51: Add dummy clock to AUDMUX
In-Reply-To: <1383813908-26571-1-git-send-email-shc_work@mail.ru>
References: <1383813908-26571-1-git-send-email-shc_work@mail.ru>
Message-ID: <1383813908-26571-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds dummy clock for AUDMUX. This change avoids useless
debug message "cannot get clock" during driver initialization.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx51.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 20e07bf..e0d7f5b 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -455,6 +455,8 @@
 			audmux: audmux at 83fd0000 {
 				compatible = "fsl,imx51-audmux", "fsl,imx31-audmux";
 				reg = <0x83fd0000 0x4000>;
+				clocks = <&clks 0>;
+				clock-names = "audmux";
 				status = "disabled";
 			};
 
-- 
1.8.1.5
