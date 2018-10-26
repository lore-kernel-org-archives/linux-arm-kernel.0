From: miyatsu@qq.com (Ding Tao)
Date: Fri, 26 Oct 2018 11:50:28 +0000
Subject: [PATCH 2/2] arm64: dts: marvell: armada-37xx: Enable emmc on
 espressobin
In-Reply-To: <20181026115028.193203-1-miyatsu@qq.com>
References: <20181026115028.193203-1-miyatsu@qq.com>
Message-ID: <20181026115028.193203-2-miyatsu@qq.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ESPRESSObin board has a emmc interface available on U11, let's
enable it.

Signed-off-by: Ding Tao <miyatsu@qq.com>
---
 .../dts/marvell/armada-3720-espressobin.dts    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
index 3ab25ad402b9..ee05aabbba88 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
@@ -60,6 +60,24 @@
 	cd-gpios = <&gpionb 3 GPIO_ACTIVE_LOW>;
 	marvell,pad-type = "sd";
 	vqmmc-supply = <&vcc_sd_reg1>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdio_pins>;
+	status = "okay";
+};
+
+/* U11 */
+&sdhci0 {
+	non-removable;
+	bus-width = <8>;
+	mmc-ddr-1_8v;
+	mmc-hs400-1_8v;
+	marvell,xenon-emmc;
+	marvell,xenon-tun-count = <9>;
+	marvell,pad-type = "fixed-1-8v";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc_pins>;
 	status = "okay";
 };
 
-- 
2.17.1
