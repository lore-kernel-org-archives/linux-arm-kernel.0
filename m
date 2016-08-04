From: fabien.lahoudere@collabora.co.uk (Fabien Lahoudere)
Date: Thu,  4 Aug 2016 15:47:32 +0200
Subject: [PATCH 1/1] imx53.dtsi: Add IPU nodes for csi
In-Reply-To: <CAOMZO5BoRsrHv-+5c9bAXO2NCya8sPqmmpy9DOfav6NvQ+VMLQ@mail.gmail.com>
References: <CAOMZO5BoRsrHv-+5c9bAXO2NCya8sPqmmpy9DOfav6NvQ+VMLQ@mail.gmail.com>
Message-ID: <1470318452-31391-1-git-send-email-fabien.lahoudere@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have the following messages that tell csi devices are not used:
imx-ipuv3 18000000.ipu: no port at 0 node in /soc/ipu at 18000000, not using CSI0
imx-ipuv3 18000000.ipu: no port at 1 node in /soc/ipu at 18000000, not using CSI1

So we add them in the common device tree to make CSI ports available on
imx53 boards.

Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
---
 arch/arm/boot/dts/imx53.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index c1bc97c..0777b41 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -136,6 +136,14 @@
 			clock-names = "bus", "di0", "di1";
 			resets = <&src 2>;
 
+			ipu_csi0: port at 0 {
+				reg = <0>;
+			};
+
+			ipu_csi1: port at 1 {
+				reg = <1>;
+			};
+
 			ipu_di0: port at 2 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
2.7.4
