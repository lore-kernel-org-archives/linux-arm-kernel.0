From: abrestic@chromium.org (Andrew Bresticker)
Date: Mon, 14 Apr 2014 18:42:43 -0700
Subject: [PATCH 4/4] ARM: tegra: fix Venice2 VQMMC regulators
In-Reply-To: <1397526163-20126-1-git-send-email-abrestic@chromium.org>
References: <1397526163-20126-1-git-send-email-abrestic@chromium.org>
Message-ID: <1397526163-20126-5-git-send-email-abrestic@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VDDIO_SDMMC3 is the VQMMC supply, not the VMMC supply, for the SD
slot.  Add 1.8V_VDDIO as the VQMMC supply for the eMMC.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/arm/boot/dts/tegra124-venice2.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index c17283c..53061ef 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -933,12 +933,13 @@
 		power-gpios = <&gpio TEGRA_GPIO(R, 0) GPIO_ACTIVE_HIGH>;
 		status = "okay";
 		bus-width = <4>;
-		vmmc-supply = <&vddio_sdmmc3>;
+		vqmmc-supply = <&vddio_sdmmc3>;
 	};
 
 	sdhci at 0,700b0600 {
 		status = "okay";
 		bus-width = <8>;
+		vqmmc-supply = <&vddio_1v8>;
 	};
 
 	ahub at 0,70300000 {
-- 
1.9.1.423.g4596e3a
