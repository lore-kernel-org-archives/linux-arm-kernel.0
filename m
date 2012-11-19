From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 19 Nov 2012 15:45:26 +0100
Subject: [PATCH 2/5] ARM: dts: exynos4210-trats: Add nodes for GPIO keys
 available on Trats
In-Reply-To: <1353336329-20818-1-git-send-email-t.figa@samsung.com>
References: <1353336329-20818-1-git-send-email-t.figa@samsung.com>
Message-ID: <1353336329-20818-3-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch extends dts file of Samsung Trats board to add support for
available GPIO keys using gpio-keys driver.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4210-trats.dts | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index 661854b..dcfa04b 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -65,6 +65,39 @@
 		status = "okay";
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		vol-down-key {
+			gpios = <&gpx2 1 1>;
+			linux,code = <114>;
+			label = "volume down";
+			debounce-interval = <10>;
+		};
+
+		vol-up-key {
+			gpios = <&gpx2 0 1>;
+			linux,code = <115>;
+			label = "volume up";
+			debounce-interval = <10>;
+		};
+
+		power-key {
+			gpios = <&gpx2 7 1>;
+			linux,code = <116>;
+			label = "power";
+			debounce-interval = <10>;
+			gpio-key,wakeup;
+		};
+
+		ok-key {
+			gpios = <&gpx3 5 1>;
+			linux,code = <352>;
+			label = "ok";
+			debounce-interval = <10>;
+		};
+	};
+
 	i2c at 138B0000 {
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-slave-addr = <0x10>;
-- 
1.8.0
