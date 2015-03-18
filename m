From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed, 18 Mar 2015 10:52:27 +0100
Subject: [PATCH v6 12/12] ARM: tegra: The WiFi card is kept powered during
 suspend
In-Reply-To: <1426672363-30667-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1426672363-30667-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1426672363-30667-13-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even if the host controller doesn't have power during suspend, the card
is kept powered.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 arch/arm/boot/dts/tegra124-nyan.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi
index 0b130cb..a9aec23 100644
--- a/arch/arm/boot/dts/tegra124-nyan.dtsi
+++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
@@ -378,6 +378,7 @@
 		mmc-pwrseq = <&sdhci0_pwrseq>;
 		vmmc-supply = <&vdd_3v3_lp0>;
 		vqmmc-supply = <&vddio_1v8>;
+		keep-power-in-suspend;
 	};
 
 	sdhci at 0,700b0400 { /* SD Card on this bus */
-- 
2.1.0
