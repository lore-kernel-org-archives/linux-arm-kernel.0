From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 22 Apr 2014 10:04:59 -0300
Subject: [PATCH v3] ARM: dts: imx6qdl-sabresd: Add HDMI support
Message-ID: <1398171899-7035-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v2:
- Removed crtcs node
- Remove CEC pin
- Tested against linux-next
Changes since v1:
- Rebased against 3.15-rc1

 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 7a88d9a..7c141f3 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -148,6 +148,11 @@
 	status = "okay";
 };
 
+&hdmi {
+	ddc-i2c-bus = <&i2c2>;
+	status = "okay";
+};
+
 &i2c1 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
-- 
1.8.3.2
