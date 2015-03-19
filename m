From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 19 Mar 2015 10:39:32 +0800
Subject: [PATCH 1/2] ARM: dts: sun4i: a10-lime: Override and remove 1008MHz
 OPP setting
In-Reply-To: <1426732773-7179-1-git-send-email-wens@csie.org>
References: <1426732773-7179-1-git-send-email-wens@csie.org>
Message-ID: <1426732773-7179-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Olimex A10-Lime is known to be unstable when running at 1008MHz.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
index 31dc2f1c3870..16ecb8938e19 100644
--- a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
+++ b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
@@ -74,6 +74,20 @@
 	status = "okay";
 };
 
+&cpu0 {
+	/* The A10-Lime is known to be unstable when running at 1008 MHz */
+	operating-points = <
+		/* kHz    uV */
+		960000  1400000
+		912000  1400000
+		864000  1300000
+		720000  1200000
+		528000  1100000
+		312000  1000000
+		144000  900000
+		>;
+};
+
 &ehci0 {
 	status = "okay";
 };
-- 
2.1.4
