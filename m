From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed, 18 Mar 2015 10:52:23 +0100
Subject: [PATCH v6 08/12] ARM: tegra: Set spi-max-frequency property to flash
 node
In-Reply-To: <1426672363-30667-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1426672363-30667-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1426672363-30667-9-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise spi core will refuse to register the device.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Acked-by: Stephen Warren <swarren@nvidia.com>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
---
 arch/arm/boot/dts/tegra124-nyan.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi
index d3a95f9..9b3fca8 100644
--- a/arch/arm/boot/dts/tegra124-nyan.dtsi
+++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
@@ -344,6 +344,7 @@
 
 		flash at 0 {
 			compatible = "winbond,w25q32dw";
+			spi-max-frequency = <25000000>;
 			reg = <0>;
 		};
 	};
-- 
2.1.0
