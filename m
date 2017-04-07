From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  7 Apr 2017 11:58:21 -0400
Subject: [PATCH 20/22] ARM: dts: genmai: Enable rtc and rtc_x1 clock
In-Reply-To: <cover.1491580547.git.horms+renesas@verge.net.au>
References: <cover.1491580547.git.horms+renesas@verge.net.au>
Message-ID: <e533a459f07c2b7bcc60121032b3b24d0c58133a.1491580547.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

Enable the 32.768 kHz RTC_X1 clock by setting the frequency value to
non-zero and enable the realtime clock.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100-genmai.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100-genmai.dts b/arch/arm/boot/dts/r7s72100-genmai.dts
index 118a8e2b86bd..52a7b586bac7 100644
--- a/arch/arm/boot/dts/r7s72100-genmai.dts
+++ b/arch/arm/boot/dts/r7s72100-genmai.dts
@@ -44,6 +44,10 @@
 	clock-frequency = <48000000>;
 };
 
+&rtc_x1_clk {
+	clock-frequency = <32768>;
+};
+
 &mtu2 {
 	status = "okay";
 };
@@ -59,6 +63,10 @@
 	};
 };
 
+&rtc {
+	status = "okay";
+};
+
 &scif2 {
 	status = "okay";
 };
-- 
2.7.0.rc3.207.g0ac5344
