From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 28 Apr 2014 12:53:39 -0600
Subject: [PATCH] ARM: tegra: add SD wp-gpios to Venice2 DT
Message-ID: <1398711219-23029-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Venice2 can detect write-protect on the SD card. Add the required
DT entries to allow this.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Thierry, could you test this for me; my Venice2 has been sent away for
a few days for some rework. You should find that if you write-protect
your SD card, the kernel fails/panics trying to mount it as a r/w root
fs, whereas if the card is not write-protected, everything still works
fine. Thanks.
---
 arch/arm/boot/dts/tegra124-venice2.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index 84a6ec039e1d..00e741ba6927 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -943,6 +943,7 @@
 	sdhci at 0,700b0400 {
 		cd-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
 		power-gpios = <&gpio TEGRA_GPIO(R, 0) GPIO_ACTIVE_HIGH>;
+		wp-gpios = <&gpio TEGRA_GPIO(Q, 4) GPIO_ACTIVE_HIGH>;
 		status = "okay";
 		bus-width = <4>;
 		vqmmc-supply = <&vddio_sdmmc3>;
-- 
1.8.1.5
