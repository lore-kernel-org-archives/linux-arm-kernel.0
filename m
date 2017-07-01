From: jacob-chen@iotwrt.com (Jacob Chen)
Date: Sat,  1 Jul 2017 20:56:10 +0800
Subject: [PATCH 3/3] arm64: dts: rockchip: enable ARM Mali GPU on
 rk3399-firefly
In-Reply-To: <1498913770-16519-1-git-send-email-jacob-chen@iotwrt.com>
References: <1498913770-16519-1-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <1498913770-16519-3-git-send-email-jacob-chen@iotwrt.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add reference to the Mali GPU device tree node on rk3399-firefly

Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
index ba1d981..601f62e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
@@ -254,6 +254,11 @@
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&vdd_gpu>;
+	status = "okay";
+};
+
 &i2c0 {
 	clock-frequency = <400000>;
 	i2c-scl-rising-time-ns = <168>;
-- 
2.7.4
