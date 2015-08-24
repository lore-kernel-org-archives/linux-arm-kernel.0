From: romain.perier@gmail.com (Romain Perier)
Date: Mon, 24 Aug 2015 18:04:41 +0200
Subject: [PATCH] ARM: dts: rockchip: Add support for SD/MMC on MarsBoard-RK3066
Message-ID: <1440432281-491-1-git-send-email-romain.perier@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables SDMMC0 on the board and gives a basic support for SD cards.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/boot/dts/rk3066a-marsboard.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a-marsboard.dts b/arch/arm/boot/dts/rk3066a-marsboard.dts
index bae965c..7189d90 100644
--- a/arch/arm/boot/dts/rk3066a-marsboard.dts
+++ b/arch/arm/boot/dts/rk3066a-marsboard.dts
@@ -186,6 +186,14 @@
 	};
 };
 
+&mmc0 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&sd0_clk>, <&sd0_cmd>, <&sd0_cd>, <&sd0_bus4>;
+	vmmc-supply = <&vcc_sd0>;
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.1.4
