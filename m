From: dev@lynxeye.de (Lucas Stach)
Date: Sun, 10 May 2015 20:30:02 +0200
Subject: [Patch v3 5/5] ARM: tegra: enable NAND flash on Colibri T20
In-Reply-To: <1431282602-7137-1-git-send-email-dev@lynxeye.de>
References: <1431282602-7137-1-git-send-email-dev@lynxeye.de>
Message-ID: <1431282602-7137-6-git-send-email-dev@lynxeye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the on-module ONFI conformant NAND flash.

Signed-off-by: Lucas Stach <dev@lynxeye.de>
---
 arch/arm/boot/dts/tegra20-colibri-512.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-colibri-512.dtsi b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
index 8e0066a..540b3fd 100644
--- a/arch/arm/boot/dts/tegra20-colibri-512.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
@@ -455,6 +455,13 @@
 		};
 	};
 
+	nand at 70008000 {
+		status = "okay";
+		nand-bus-width = <8>;
+		nand-on-flash-bbt;
+		nvidia,wp-gpios = <&gpio TEGRA_GPIO(S, 0) GPIO_ACTIVE_HIGH>;
+	};
+
 	usb at c5004000 {
 		status = "okay";
 		nvidia,phy-reset-gpio = <&gpio TEGRA_GPIO(V, 1)
-- 
2.1.0
