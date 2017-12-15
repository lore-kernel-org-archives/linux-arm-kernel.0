From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Fri, 15 Dec 2017 12:00:03 +0100
Subject: [PATCH v3 3/5] arm64: dts: rockchip: add usb3-phy otg-port support
 for rk3399.
In-Reply-To: <20171215110005.7564-1-enric.balletbo@collabora.com>
References: <20171215110005.7564-1-enric.balletbo@collabora.com>
Message-ID: <20171215110005.7564-3-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the usb3 phyter for the USB3.0 OTG controller.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Changes since v1:
 - Split the original patch in different commits
Changes since v2:
 - None

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index f32e9c4..ea91f25 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -409,8 +409,8 @@
 			reg = <0x0 0xfe800000 0x0 0x100000>;
 			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH 0>;
 			dr_mode = "otg";
-			phys = <&u2phy0_otg>;
-			phy-names = "usb2-phy";
+			phys = <&u2phy0_otg>, <&tcphy0_usb3>;
+			phy-names = "usb2-phy", "usb3-phy";
 			phy_type = "utmi_wide";
 			snps,dis_enblslpm_quirk;
 			snps,dis-u2-freeclk-exists-quirk;
@@ -439,8 +439,8 @@
 			reg = <0x0 0xfe900000 0x0 0x100000>;
 			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH 0>;
 			dr_mode = "otg";
-			phys = <&u2phy1_otg>;
-			phy-names = "usb2-phy";
+			phys = <&u2phy1_otg>, <&tcphy1_usb3>;
+			phy-names = "usb2-phy", "usb3-phy";
 			phy_type = "utmi_wide";
 			snps,dis_enblslpm_quirk;
 			snps,dis-u2-freeclk-exists-quirk;
-- 
2.9.3
