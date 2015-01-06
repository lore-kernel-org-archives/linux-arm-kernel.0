From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue,  6 Jan 2015 11:37:29 +0100
Subject: [PATCH 4/4] ARM: tegra: remove wp-gpios from the generic nyan dtsi
In-Reply-To: <1420540653-14816-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1420540653-14816-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1420540653-14816-5-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the nyan-blaze has a micro-sd slot, as opposed to nyan-big, which has a full SD
slot.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 arch/arm/boot/dts/tegra124-nyan-big.dts | 4 ++++
 arch/arm/boot/dts/tegra124-nyan.dtsi    | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra124-nyan-big.dts b/arch/arm/boot/dts/tegra124-nyan-big.dts
index 2041077..598c090 100644
--- a/arch/arm/boot/dts/tegra124-nyan-big.dts
+++ b/arch/arm/boot/dts/tegra124-nyan-big.dts
@@ -6,6 +6,10 @@
 	model = "Acer Chromebook 13 CB5-311";
 	compatible = "google,nyan-big", "google,nyan", "nvidia,tegra124";
 
+	sdhci at 0,700b0400 { /* SD Card on this bus */
+		wp-gpios = <&gpio TEGRA_GPIO(Q, 4) GPIO_ACTIVE_LOW>;
+	};
+
 	sound {
 		nvidia,model = "Acer Chromebook 13 CB5-311";
 	};
diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi
index 4c68658..12d757e 100644
--- a/arch/arm/boot/dts/tegra124-nyan.dtsi
+++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
@@ -820,7 +820,6 @@
 		status = "okay";
 		cd-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
 		power-gpios = <&gpio TEGRA_GPIO(R, 0) GPIO_ACTIVE_HIGH>;
-		wp-gpios = <&gpio TEGRA_GPIO(Q, 4) GPIO_ACTIVE_LOW>;
 		bus-width = <4>;
 		no-1-8-v;
 		vqmmc-supply = <&vddio_sdmmc3>;
-- 
1.9.3
