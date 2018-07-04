From: codekipper@gmail.com (codekipper at gmail.com)
Date: Wed,  4 Jul 2018 10:30:03 +0200
Subject: [linux-sunxi][PATCH v2] ARM: dts: sun8i: h3: Enable dwmac-sun8i on
 the Beelink X2
Message-ID: <20180704083003.26849-1-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

The enabling of the EMAC was reverted as there was an issue on how
to handle the integrated PHY and it was getting close to the release
window (fe45174b72ae ("arm: dts: sunxi: Revert EMAC changes")).

When a solution was found, then the changes were restored in
4b236a0fe512 ("arm: dts: sunxi: h3/h5: Restore EMAC changes") and
4904337fe34f ("ARM: dts: sunxi: Restore EMAC changes (boards)").
Unfortunately enabling for the Beelink X2 was missed.

This reverts partially commit 6b0e06df5cad (Revert "ARM: dts:
sun8i: h3: Enable dwmac-sun8i on the Beelink X2")

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
Changes for v2:
- Added more details in commit message about the reverting and restoring
  patches.
---
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
index cf1f970b0c6f..5d23667dc2d2 100644
--- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
@@ -123,6 +123,13 @@
 	status = "okay";
 };
 
+&emac {
+	phy-handle = <&int_mii_phy>;
+	phy-mode = "mii";
+	allwinner,leds-active-low;
+	status = "okay";
+};
+
 &hdmi {
 	status = "okay";
 };
-- 
2.18.0
