From: stefan@agner.ch (Stefan Agner)
Date: Wed,  6 Dec 2017 16:29:58 +0100
Subject: [PATCH 2/9] ARM: dts: imx7-colibri: make sure multiplexed pins are
 not active
In-Reply-To: <20171206153005.6144-1-stefan@agner.ch>
References: <20171206153005.6144-1-stefan@agner.ch>
Message-ID: <20171206153005.6144-2-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Colibri pins PWM<A> and <D> are multiplexed on the module, make
sure the secondary SoC pin is not active.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx7-colibri.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index 60ea7557d8c9..dae6b561145b 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -507,6 +507,7 @@
 	pinctrl_pwm1: pwm1-grp {
 		fsl,pins = <
 			MX7D_PAD_GPIO1_IO08__PWM1_OUT		0x79
+			MX7D_PAD_ECSPI2_MOSI__GPIO4_IO21	0x4
 		>;
 	};
 
@@ -525,6 +526,7 @@
 	pinctrl_pwm4: pwm4-grp {
 		fsl,pins = <
 			MX7D_PAD_GPIO1_IO11__PWM4_OUT		0x79
+			MX7D_PAD_ECSPI2_SCLK__GPIO4_IO20	0x4
 		>;
 	};
 
-- 
2.15.1
