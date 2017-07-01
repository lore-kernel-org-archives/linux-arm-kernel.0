From: jacob-chen@iotwrt.com (Jacob Chen)
Date: Sat,  1 Jul 2017 10:02:44 +0800
Subject: [PATCH 2/5] ARM: dts: rockchip: enable ARM Mali GPU on rk3288-evb
In-Reply-To: <1498874567-11219-1-git-send-email-jacob-chen@iotwrt.com>
References: <1498874567-11219-1-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <1498874567-11219-3-git-send-email-jacob-chen@iotwrt.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add reference to the Mali GPU device tree node on rk3288-evb.
Tested on rk3288-evb-act8846 board.

Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>
---
 arch/arm/boot/dts/rk3288-evb.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index 0dec94c..f226ca7 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -248,6 +248,11 @@
 	status = "ok";
 };
 
+&gpu {
+	mali-supply = <&vdd_gpu>;
+	status = "okay";
+};
+
 &hdmi {
 	ddc-i2c-bus = <&i2c5>;
 	status = "okay";
-- 
2.7.4
