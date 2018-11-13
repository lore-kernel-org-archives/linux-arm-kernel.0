From: christoph.muellner@theobroma-systems.com (Christoph Muellner)
Date: Tue, 13 Nov 2018 11:25:35 +0100
Subject: [PATCH] arm64: dts: rockchip: Fix PCIe reset polarity for
 rk3399-puma-haikou.
Message-ID: <20181113102535.444-1-christoph.muellner@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the wrong polarity setting for the PCIe host driver's
pre-reset pin for rk3399-puma-haikou. Without this patch link training
will most likely fail.

Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
index 2dceeea29b83..1e6a71066c16 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
@@ -153,7 +153,7 @@
 };
 
 &pcie0 {
-	ep-gpios = <&gpio4 RK_PC6 GPIO_ACTIVE_LOW>;
+	ep-gpios = <&gpio4 RK_PC6 GPIO_ACTIVE_HIGH>;
 	num-lanes = <4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie_clkreqn_cpm>;
-- 
2.11.0
