From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 17 Sep 2014 00:48:51 +0200
Subject: [PATCH 2/2] ARM: dts: rockchip: fix rk3188 emmc pull references
In-Reply-To: <6217952.a0HdpFGHLC@diego>
References: <6217952.a0HdpFGHLC@diego>
Message-ID: <2752807.VRWBxDm8Q6@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix a copy'n'paste error making the rk3188 emmc pinctrl nodes reference
the pcfg_pull_default setting that is not available on rk3188.

Reported-by: Naoki FUKAUMI <naobsd@gmail.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3188.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 9a1ff0b..82732f5 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -149,15 +149,15 @@
 
 		emmc {
 			emmc_clk: emmc-clk {
-				rockchip,pins = <RK_GPIO0 24 RK_FUNC_2 &pcfg_pull_default>;
+				rockchip,pins = <RK_GPIO0 24 RK_FUNC_2 &pcfg_pull_none>;
 			};
 
 			emmc_cmd: emmc-cmd {
-				rockchip,pins = <RK_GPIO0 26 RK_FUNC_2 &pcfg_pull_default>;
+				rockchip,pins = <RK_GPIO0 26 RK_FUNC_2 &pcfg_pull_up>;
 			};
 
 			emmc_rst: emmc-rst {
-				rockchip,pins = <RK_GPIO0 27 RK_FUNC_2 &pcfg_pull_default>;
+				rockchip,pins = <RK_GPIO0 27 RK_FUNC_2 &pcfg_pull_none>;
 			};
 
 			/*
-- 
2.0.1
