From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 15 Jan 2015 17:12:13 +0100
Subject: [PATCH v2 01/11] ARM: tegra: Add node for trackpad in Nyan boards
In-Reply-To: <1421338359-27467-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1421338359-27467-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1421338359-27467-2-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Nyan boards have a eKTH3000 from Elan as their trackpad, connected
through I2C.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 arch/arm/boot/dts/tegra124-nyan-big.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-nyan-big.dts b/arch/arm/boot/dts/tegra124-nyan-big.dts
index 004e8e4..e953fe2 100644
--- a/arch/arm/boot/dts/tegra124-nyan-big.dts
+++ b/arch/arm/boot/dts/tegra124-nyan-big.dts
@@ -526,6 +526,14 @@
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
