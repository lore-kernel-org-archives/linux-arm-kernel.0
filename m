From: zyw@rock-chips.com (Chris Zhong)
Date: Tue,  7 Nov 2017 10:49:19 +0800
Subject: [PATCH] ARM: dts: add phy-reset property for rk3066a-rayeager emac
Message-ID: <1510022959-19440-1-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ethernet phy of rk3066a-rayeager has a reset pin, it controlled by
GPIO1_D6, this pin should be pull down then pull up to reset the phy.
Add a phy-reset property in emac, make the phy can be reset when emac
power on.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

 arch/arm/boot/dts/rk3066a-rayeager.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a-rayeager.dts b/arch/arm/boot/dts/rk3066a-rayeager.dts
index 570157f..6064a0a 100644
--- a/arch/arm/boot/dts/rk3066a-rayeager.dts
+++ b/arch/arm/boot/dts/rk3066a-rayeager.dts
@@ -173,6 +173,8 @@
 	pinctrl-0 = <&emac_xfer>, <&emac_mdio>, <&rmii_rst>;
 	phy = <&phy0>;
 	phy-supply = <&vcc_rmii>;
+	phy-reset-gpios = <&gpio1 RK_PD6 GPIO_ACTIVE_LOW>; /* PHY_RST */
+	phy-reset-duration = <10>; /* millisecond */
 	status = "okay";
 
 	phy0: ethernet-phy at 0 {
-- 
2.7.4
