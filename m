From: ykk@rock-chips.com (Yakir Yang)
Date: Wed, 22 Jun 2016 10:54:40 +0800
Subject: [PATCH v3 4/4] arm64: dtsi: rockchip: introduce pclk_vio_grf in eDP
 device node
In-Reply-To: <1466564038-18021-1-git-send-email-ykk@rock-chips.com>
References: <1466564038-18021-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1466564080-18351-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pclk_vio_grf supply power for VIO GRF IOs, if it is disabled, driver
would failed to operate the VIO GRF registers.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v3:
- Add this patch in v3, due to another patch[0] need.
  [0]: https://patchwork.kernel.org/patch/9191737/

Changes in v2: None

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index be322db..e3e0cb6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -609,8 +609,8 @@
 		compatible = "rockchip,rk3399-edp";
 		reg = <0x0 0xff970000 0x0 0x8000>;
 		interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru PCLK_EDP>, <&cru PCLK_EDP_CTRL>;
-		clock-names = "dp", "pclk";
+		clocks = <&cru PCLK_EDP>, <&cru PCLK_EDP_CTRL>, <&cru PCLK_VIO_GRF>;
+		clock-names = "dp", "pclk", "grf";
 		resets = <&cru SRST_P_EDP_CTRL>;
 		reset-names = "dp";
 		rockchip,grf = <&grf>;
-- 
1.9.1
