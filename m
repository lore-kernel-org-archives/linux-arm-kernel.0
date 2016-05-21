From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 21 May 2016 23:23:47 +0200
Subject: [PATCH 2/3] arm64: dts: rockchip: add rk3368-r88 iodomains
In-Reply-To: <1463865828-14583-1-git-send-email-heiko@sntech.de>
References: <1463865828-14583-1-git-send-email-heiko@sntech.de>
Message-ID: <1463865828-14583-3-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the supply-links according to the R88 schematics.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
index b56b720..82a32e5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
@@ -236,6 +236,15 @@
 	};
 };
 
+&io_domains {
+	status = "ok";
+
+	audio-supply = <&vcc_io>;
+	gpio30-supply = <&vcc_io>;
+	gpio1830-supply = <&vcc_io>;
+	wifi-supply = <&vccio_wl>;
+};
+
 &sdio0 {
 	assigned-clocks = <&cru SCLK_SDIO0>;
 	assigned-clock-parents = <&cru PLL_CPLL>;
@@ -329,6 +338,13 @@
 	};
 };
 
+&pmu_io_domains {
+	status = "okay";
+
+	pmu-supply = <&vcc_io>;
+	vop-supply = <&vcc_io>;
+};
+
 &saradc {
 	vref-supply = <&vcc_18>;
 	status = "okay";
-- 
2.6.4
