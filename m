From: briannorris@chromium.org (Brian Norris)
Date: Fri, 13 May 2016 15:12:04 -0700
Subject: [PATCH v4 3/3] ARM64: dts: rockchip: enable eMMC for rk3399 EVB
In-Reply-To: <1463177524-113856-1-git-send-email-briannorris@chromium.org>
References: <1463177524-113856-1-git-send-email-briannorris@chromium.org>
Message-ID: <1463177524-113856-3-git-send-email-briannorris@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rockchip's rk3399 evaluation board has eMMC. Let's enable the
newly-added nodes.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
v4:

 * alphabetize &node references

v3:

 * no change

v2:

 * better commit description

 arch/arm64/boot/dts/rockchip/rk3399-evb.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
index 1a3eb1482050..d33aa06d46f5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
@@ -77,6 +77,10 @@
 	};
 };
 
+&emmc_phy {
+	status = "okay";
+};
+
 &pwm0 {
 	status = "okay";
 };
@@ -89,6 +93,14 @@
 	status = "okay";
 };
 
+&sdhci {
+	bus-width = <8>;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+	non-removable;
+	status = "okay";
+};
+
 &uart2 {
 	status = "okay";
 };
-- 
2.8.0.rc3.226.g39d4020
