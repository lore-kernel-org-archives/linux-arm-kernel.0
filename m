From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 20 Mar 2015 14:49:19 +0800
Subject: [PATCH v2 1/2] ARM: dts: sun4i: a10-lime: Override and remove 1008MHz
 OPP setting
In-Reply-To: <1426834160-10409-1-git-send-email-wens@csie.org>
References: <1426834160-10409-1-git-send-email-wens@csie.org>
Message-ID: <1426834160-10409-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Olimex A10-Lime is known to be unstable when running at 1008MHz.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
index 31dc2f1c3870..df9535b5009c 100644
--- a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
+++ b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
@@ -74,6 +74,17 @@
 	status = "okay";
 };
 
+&cpu0 {
+	/* The A10-Lime is known to be unstable when running at 1008 MHz */
+	operating-points = <
+		/* kHz    uV */
+		912000  1350000
+		864000  1300000
+		624000  1250000
+		>;
+	cooling-max-level = <2>;
+};
+
 &ehci0 {
 	status = "okay";
 };
-- 
2.1.4
