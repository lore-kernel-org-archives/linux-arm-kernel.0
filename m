From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 2 Aug 2012 22:23:54 +0800
Subject: [PATCH] ARM: dts: imx: fix gpio interrupts property
In-Reply-To: <CAOMZO5D1oM0q2H=ZqNc3Jq9T5+kGypnDbFC8O1a5D6qQYy1ySA@mail.gmail.com>
References: <CAOMZO5D1oM0q2H=ZqNc3Jq9T5+kGypnDbFC8O1a5D6qQYy1ySA@mail.gmail.com>
Message-ID: <1343917434-4358-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 88cde8b (ARM: dts: imx: update #interrupt-cells for gpio nodes)
changes gpio #interrupt-cells from 1 to 2 without updating the users.
It causes the gpio irq requesting call failing in client driver's probe
function.

Add the irq type cell for those gpio interrupt users to fix their
driver probe failure.

Reported-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx51-babbage.dts |    2 +-
 arch/arm/boot/dts/imx53-ard.dts     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index de065b5..cd86177 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -53,7 +53,7 @@
 						spi-max-frequency = <6000000>;
 						reg = <0>;
 						interrupt-parent = <&gpio1>;
-						interrupts = <8>;
+						interrupts = <8 0x4>;
 
 						regulators {
 							sw1_reg: sw1 {
diff --git a/arch/arm/boot/dts/imx53-ard.dts b/arch/arm/boot/dts/imx53-ard.dts
index 5b8eafc..a02083a 100644
--- a/arch/arm/boot/dts/imx53-ard.dts
+++ b/arch/arm/boot/dts/imx53-ard.dts
@@ -64,7 +64,7 @@
 			reg = <0xf4000000 0x2000000>;
 			phy-mode = "mii";
 			interrupt-parent = <&gpio2>;
-			interrupts = <31>;
+			interrupts = <31 0x8>;
 			reg-io-width = <4>;
 			smsc,irq-push-pull;
 		};
-- 
1.7.5.4
