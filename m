From: wxt@rock-chips.com (Caesar Wang)
Date: Mon, 15 Feb 2016 11:30:58 +0800
Subject: [PATCH] arm64: dts: rockchip: fix the incorrect otp-out pin on rk3368
Message-ID: <1455507058-10824-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the incorrect Over-temperature protection pin.
since the rk3368 io list said the otp pin is gpio0a3.

Anyway, that should be fixed in here.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 49d1191..3949163 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -926,11 +926,11 @@
 
 		tsadc {
 			otp_gpio: otp-gpio {
-				rockchip,pins = <0 10 RK_FUNC_GPIO &pcfg_pull_none>;
+				rockchip,pins = <0 3 RK_FUNC_GPIO &pcfg_pull_none>;
 			};
 
 			otp_out: otp-out {
-				rockchip,pins = <0 10 RK_FUNC_1 &pcfg_pull_none>;
+				rockchip,pins = <0 3 RK_FUNC_1 &pcfg_pull_none>;
 			};
 		};
 
-- 
1.9.1
