From: heiko.stuebner@collabora.com (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 30 Nov 2015 14:14:26 +0100
Subject: [PATCH 2/2] ARM: dts: rockchip: override thermal settings on
 veyron-speedy
In-Reply-To: <2402718.WBE9iyTUZ2@diego>
References: <2402718.WBE9iyTUZ2@diego>
Message-ID: <2523702.pCcOIjvoVs@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to a commit on the ChromeOS kernel, the temperature of the Speedy
surface is over skin temperature spec. So adjust the thermal settings
to mimic the ChromeOS tree to stay within these spec limits.

Signed-off-by: Heiko Stuebner <heiko.stuebner@collabora.com>
---
 arch/arm/boot/dts/rk3288-veyron-speedy.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron-speedy.dts b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
index a7ea7d0..b34a7b5 100644
--- a/arch/arm/boot/dts/rk3288-veyron-speedy.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
@@ -88,6 +88,14 @@
 	};
 };
 
+&cpu_alert0 {
+	temperature = <65000>;
+};
+
+&cpu_alert1 {
+	temperature = <70000>;
+};
+
 &rk808 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pmic_int_l>;
-- 
2.6.1
