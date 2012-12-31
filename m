From: tobetter@gmail.com (Dongjin Kim)
Date: Mon, 31 Dec 2012 11:35:13 +0900
Subject: [PATCH v3 4/4] ODROID-X: dts: Add mshc node for ODROID-X board
In-Reply-To: <1356921314-12595-1-git-send-email-tobetter@gmail.com>
References: <1356921314-12595-1-git-send-email-tobetter@gmail.com>
Message-ID: <1356921314-12595-5-git-send-email-tobetter@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding the device node to support eMMC storage on SDCARD4 ports, controlled by
Mobile Storage Host Controller.

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
---
 arch/arm/boot/dts/exynos4412-odroidx.dts |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
index f31529f..04c482e 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
@@ -70,4 +70,24 @@
 			linux,default-trigger = "mmc0";
 		};
 	};
+
+	mshc at 12550000 {
+		pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
+		pinctrl-names = "default";
+		status = "okay";
+
+		num-slots = <1>;
+		supports-highspeed;
+		broken-cd;
+		fifo-depth = <0x80>;
+		card-detect-delay = <200>;
+		samsung,dw-mshc-ciu-div = <3>;
+		samsung,dw-mshc-sdr-timing = <2 3 3>;
+		samsung,dw-mshc-ddr-timing = <1 2 3>;
+
+		slot at 0 {
+			reg = <0>;
+			bus-width = <8>;
+		};
+	};
 };
-- 
1.7.10.4
