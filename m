From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  7 Apr 2017 11:58:19 -0400
Subject: [PATCH 18/22] ARM: dts: rskrza1: set rtc_x1 clock value
In-Reply-To: <cover.1491580547.git.horms+renesas@verge.net.au>
References: <cover.1491580547.git.horms+renesas@verge.net.au>
Message-ID: <f90c36448aacde1fd41332659a12cbc9558b1137.1491580547.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Brandt <chris.brandt@renesas.com>

Enable the 32.768 kHz RTC_X1 clock by setting the frequency value to
non-zero.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100-rskrza1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100-rskrza1.dts b/arch/arm/boot/dts/r7s72100-rskrza1.dts
index 02b59c5b3c53..cab5857bfb41 100644
--- a/arch/arm/boot/dts/r7s72100-rskrza1.dts
+++ b/arch/arm/boot/dts/r7s72100-rskrza1.dts
@@ -43,6 +43,10 @@
 	clock-frequency = <48000000>;
 };
 
+&rtc_x1_clk {
+	clock-frequency = <32768>;
+};
+
 &mtu2 {
 	status = "okay";
 };
-- 
2.7.0.rc3.207.g0ac5344
