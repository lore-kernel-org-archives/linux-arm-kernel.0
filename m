From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 19 Aug 2014 17:08:32 +0200
Subject: [PATCH 5/6] ARM: dts: Add vmmc and vqmmc supplies for Peach Pit and
 Pi boards
In-Reply-To: <1408460913-13863-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1408460913-13863-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1408460913-13863-6-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VCC/VDD and VCCQ/VDD_IO power supplies for the MMC are
provided by the tps65090 fet4 and max77802 ldo4 regulators
respectively. Add the phandle to the regulators tree nodes
for the the dw_mmc device device.

These DTS snippets were taken from the downstream ChromeOS
3.8 kernel Device Tree for Peach Pit and Pi boards.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/exynos5420-peach-pit.dts | 2 ++
 arch/arm/boot/dts/exynos5800-peach-pi.dts  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 8e50042..5b9dbb9 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -547,6 +547,8 @@
 };
 
 &mmc_2 {
+	vmmc-supply = <&tps65090_fet4>;
+	vqmmc-supply = <&vqmmc_sdcard>;
 	status = "okay";
 	num-slots = <1>;
 	supports-highspeed;
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 939f91c..dcac443 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -545,6 +545,8 @@
 };
 
 &mmc_2 {
+	vmmc-supply = <&tps65090_fet4>;
+	vqmmc-supply = <&vqmmc_sdcard>;
 	status = "okay";
 	num-slots = <1>;
 	supports-highspeed;
-- 
2.0.1
