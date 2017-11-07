From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Tue, 7 Nov 2017 12:29:31 -0200
Subject: [PATCH] ARM: dts: imx6qdl-wandboard-revd1: Make EDID functional
Message-ID: <1510064971-18755-1-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are 0 ohm resistors that allow selecting the EDID I2C port to
be I2C1 or I2C2.

On revd1 the 0 ohm resistors are populated in such a way that the I2C2
is used as DDC I2C bus, so fix it accordingly. 

Reported-by: Lu?s Mendes <luis.p.mendes@gmail.com>
Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi
index 6d8d9ca..3a8a495 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi
@@ -21,6 +21,11 @@
 	};
 };
 
+&hdmi {
+	ddc-i2c-bus = <&i2c2>;
+	status = "okay";
+};
+
 &i2c3 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
-- 
2.7.4
