From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed, 28 Jan 2015 11:51:08 +0100
Subject: [PATCH v3 10/10] ARM: tegra: Set spi-max-frequency property to flash
 node
In-Reply-To: <1422442278-10405-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1422442278-10405-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1422442278-10405-11-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise spi core will refuse to register the device.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 arch/arm/boot/dts/tegra124-nyan.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi
index 632d181..6752e95 100644
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
1.9.3
