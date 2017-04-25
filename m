From: guillaume.tucker@collabora.com (Guillaume Tucker)
Date: Tue, 25 Apr 2017 14:16:20 +0100
Subject: [PATCH v4 5/5] ARM: dts: rockchip: enable ARM Mali GPU on
 rk3288-veyron
In-Reply-To: <cover.1493125299.git.guillaume.tucker@collabora.com>
References: <cover.1493125299.git.guillaume.tucker@collabora.com>
Message-ID: <cf657d2e27d10c0611fe0ee0914fcbb0019cf4af.1493125299.git.guillaume.tucker@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Add reference to the Mali GPU device tree node on rk3288-veyron.
Tested on Minnie and Jerry boards.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
---
 arch/arm/boot/dts/rk3288-veyron.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index 5d1eb0a25827..9847d5c6db3b 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -447,6 +447,11 @@
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&vdd_gpu>;
+	status = "okay";
+};
+
 &wdt {
 	status = "okay";
 };
-- 
2.11.0
