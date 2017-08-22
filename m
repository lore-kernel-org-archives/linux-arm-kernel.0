From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue, 22 Aug 2017 12:04:00 +0800
Subject: [PATCH v2 4/4] arm64: allwinner: a64: disable the RTL8211E internal
 RX delay on Pine64+
In-Reply-To: <20170822040400.12166-1-icenowy@aosc.io>
References: <20170822040400.12166-1-icenowy@aosc.io>
Message-ID: <20170822040400.12166-5-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some Pine64+ boards have a broken RTL8211E PHY, which cannot work
reliably in 1000Base-T mode with default configuration.

A solution is passed to Pine64, which is said to be disabling the
internal RX delay of the PHY.

Enable the hack by set the PHY mode to RGMII-TXID.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v2:
- It can be merged now as dwmac-sun8i entered mainline.
- Use phy-mode rgmii-txid instead of custom property.

 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
index 24f1aac366d6..ed715426fffc 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
@@ -52,7 +52,7 @@
 &emac {
 	pinctrl-names = "default";
 	pinctrl-0 = <&rgmii_pins>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-txid";
 	phy-handle = <&ext_rgmii_phy>;
 	status = "okay";
 };
-- 
2.13.5
