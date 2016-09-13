From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 13 Sep 2016 17:51:06 +0000
Subject: [PATCH 4/4] ARM: dts: imx28: add On-Chip RAM
In-Reply-To: <1473789066-8955-1-git-send-email-stefan.wahren@i2se.com>
References: <1473789066-8955-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1473789066-8955-5-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the node for the 128 KB On-Chip RAM of the i.MX28.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/imx28.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index e483f61..eefff7e1 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -1237,6 +1237,11 @@
 		#size-cells = <1>;
 		ranges;
 
+		ocram: sram at 00000000 {
+			compatible = "mmio-sram";
+			reg = <0x00000000 0x20000>;
+		};
+
 		usb0: usb at 80080000 {
 			compatible = "fsl,imx28-usb", "fsl,imx27-usb";
 			reg = <0x80080000 0x10000>;
-- 
1.7.9.5
