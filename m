From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Oct 2017 12:28:08 +0200
Subject: [PATCH 05/31] arm64: dts: renesas: salvator-common: add pfc node for
 USB3.0 channel 0
In-Reply-To: <cover.1508495040.git.horms+renesas@verge.net.au>
References: <cover.1508495040.git.horms+renesas@verge.net.au>
Message-ID: <73de4b8847892fa7d6fffd14139c5083a3fd1580.1508495040.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Since a R-Car Gen3 bootloader enables the PFC of USB3.0 channel 0,
the USB3.0 host controller works without this setting on the kernel.
But, this setting should have salvator-common.dtsi. So, this patch
adds the pfc node for USB3.0 channel 0.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/salvator-common.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
index 99d8180c71f7..af434dcd2197 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -485,6 +485,11 @@
 			bias-pull-down;
 		};
 	};
+
+	usb30_pins: usb30 {
+		groups = "usb30";
+		function = "usb30";
+	};
 };
 
 &pwm1 {
@@ -620,5 +625,8 @@
 };
 
 &xhci0 {
+	pinctrl-0 = <&usb30_pins>;
+	pinctrl-names = "default";
+
 	status = "okay";
 };
-- 
2.11.0
