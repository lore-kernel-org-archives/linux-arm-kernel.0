From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 23 Jul 2013 11:11:45 -0700
Subject: [PATCH] ARM: tegra: enable ULPI phy on Colibri T20
Message-ID: <1374603105-21226-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lucas Stach <dev@lynxeye.de>

This was missed when splitting out the phy from the controller node in
commit 9dffe3be3f32 (ARM: tegra: modify ULPI reset GPIO properties).

Signed-off-by: Lucas Stach <dev@lynxeye.de>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Olof, Arnd, this is a fix for 3.11. Thanks!

 arch/arm/boot/dts/tegra20-colibri-512.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra20-colibri-512.dtsi b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
index 2fcb3f2..5592be6 100644
--- a/arch/arm/boot/dts/tegra20-colibri-512.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
@@ -457,6 +457,7 @@
 	};
 
 	usb-phy at c5004000 {
+		status = "okay";
 		nvidia,phy-reset-gpio = <&gpio TEGRA_GPIO(V, 1)
 			GPIO_ACTIVE_LOW>;
 	};
-- 
1.7.10.4
