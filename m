From: jacob-chen@iotwrt.com (Jacob Chen)
Date: Sat,  1 Jul 2017 21:10:01 +0800
Subject: [PATCH v2] ARM: dts: rockchip: enable saradc for rk3288-evb
Message-ID: <1498914601-6241-1-git-send-email-jacob-chen@iotwrt.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

saradc in rk3288-evb use 1.8v ref.

Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>
---
 arch/arm/boot/dts/rk3288-evb.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index f226ca7..f549f91 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -218,6 +218,11 @@
 	status = "okay";
 };
 
+&saradc {
+	vref-supply = <&vcc_18>;
+	status = "okay";
+};
+
 &sdmmc {
 	bus-width = <4>;
 	cap-mmc-highspeed;
-- 
2.7.4
