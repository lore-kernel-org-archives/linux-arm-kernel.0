From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 10 Oct 2015 22:48:59 +0800
Subject: [PATCH v2 4/5] ARM: dts: sun6i: hummingbird: Enable AXP221 DC5LDO
 regulator as "vdd-cpus"
In-Reply-To: <1444488540-11263-1-git-send-email-wens@csie.org>
References: <1444488540-11263-1-git-send-email-wens@csie.org>
Message-ID: <1444488540-11263-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DC5LDO regulator supplies VDD-CPUS, which is for the embedded
controller in the A31 SoC.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index a9b87ae89855..9a74637f677f 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -200,6 +200,12 @@
 	regulator-name = "avcc";
 };
 
+&reg_dc5ldo {
+	regulator-min-microvolt = <700000>;
+	regulator-max-microvolt = <1320000>;
+	regulator-name = "vdd-cpus";
+};
+
 &reg_dcdc1 {
 	regulator-always-on;
 	regulator-min-microvolt = <3000000>;
-- 
2.5.3
