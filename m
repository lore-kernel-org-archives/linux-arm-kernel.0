From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon,  8 Feb 2016 03:17:34 +0100
Subject: [PATCH v2 05/10] ARM64: dts: rockchip: Add eMMC to GeekBox
In-Reply-To: <1454897859-7601-1-git-send-email-afaerber@suse.de>
References: <1454897859-7601-1-git-send-email-afaerber@suse.de>
Message-ID: <1454897859-7601-6-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2: New
 
 arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts b/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
index a8dcf3c2b0c1..e4523a74050f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
@@ -89,6 +89,21 @@
 	};
 };
 
+&emmc {
+	status = "okay";
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	clock-frequency = <150000000>;
+	disable-wp;
+	keep-power-in-suspend;
+	non-removable;
+	num-slots = <1>;
+	vmmc-supply = <&vcc_io>;
+	vqmmc-supply = <&vcc18_flash>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_clk>, <&emmc_cmd>, <&emmc_bus8>;
+};
+
 &gmac {
 	status = "okay";
 	phy-supply = <&vcc_lan>;
-- 
2.6.2
