From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 31 Mar 2016 22:54:11 +0200
Subject: [PATCH 5/5] ARM: dts: rockchip: add missing unitname to cpu_leakage
 efuse
In-Reply-To: <1459457651-4727-1-git-send-email-heiko@sntech.de>
References: <1459457651-4727-1-git-send-email-heiko@sntech.de>
Message-ID: <1459457651-4727-6-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpu_leakage efuse on rk3288 did get it right including the
unitname but on both rk3066a and rk3188 it was missing, fix that.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3066a.dtsi | 2 +-
 arch/arm/boot/dts/rk3188.dtsi  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index c84a306..c0ba86c 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -169,7 +169,7 @@
 		clocks = <&cru PCLK_EFUSE>;
 		clock-names = "pclk_efuse";
 
-		cpu_leakage: cpu_leakage {
+		cpu_leakage: cpu_leakage at 17 {
 			reg = <0x17 0x1>;
 		};
 	};
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index c44c318..31f81b2 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -154,7 +154,7 @@
 		clocks = <&cru PCLK_EFUSE>;
 		clock-names = "pclk_efuse";
 
-		cpu_leakage: cpu_leakage {
+		cpu_leakage: cpu_leakage at 17 {
 			reg = <0x17 0x1>;
 		};
 	};
-- 
2.6.4
