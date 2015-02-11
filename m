From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed, 11 Feb 2015 16:06:37 +0100
Subject: [PATCH v4 05/11] ARM: tegra: Add node for trackpad in Nyan boards
In-Reply-To: <1423667220-1062-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1423667220-1062-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1423667220-1062-6-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Nyan boards have a eKTH3000 from Elan as their trackpad, connected
through I2C.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 arch/arm/boot/dts/tegra124-nyan.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi
index c0ee53f..579b0b9 100644
--- a/arch/arm/boot/dts/tegra124-nyan.dtsi
+++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
@@ -71,6 +71,14 @@
 	i2c at 0,7000c400 {
 		status = "okay";
 		clock-frequency = <100000>;
+
+		trackpad at 15 {
+			compatible = "elan,ekth3000";
+			reg = <0x15>;
+			interrupt-parent = <&gpio>;
+			interrupts = <TEGRA_GPIO(W, 3) IRQ_TYPE_EDGE_FALLING>;
+			wakeup-source;
+		};
 	};
 
 	i2c at 0,7000c500 {
-- 
1.9.3
