From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Mon, 31 Mar 2014 17:40:03 +0200
Subject: [PATCH 6/6] ARM: socfpga: dts: add rtc on i2c0 to socrates
In-Reply-To: <1396280404-2041-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1396280404-2041-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1396280404-2041-6-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SOCrates has an M41T82M RTC on i2c0. Add it.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/socfpga_cyclone5_socrates.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts b/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
index 1e31f32..f8d17dc 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
@@ -36,6 +36,15 @@
 	status = "okay";
 };
 
+&i2c0 {
+	status = "okay";
+
+	rtc: rtc at 68 {
+		compatible = "stm,m41t82";
+		reg = <0x68>;
+	};
+};
+
 &mmc {
 	status = "okay";
 };
-- 
1.9.1
