From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 31 Mar 2016 15:48:43 +0200
Subject: [PATCH v2 2/5] ARM: dts: rockchip: make rk3288-grf a simple-mfd
In-Reply-To: <1459432126-6395-1-git-send-email-heiko@sntech.de>
References: <1459432126-6395-1-git-send-email-heiko@sntech.de>
Message-ID: <1459432126-6395-3-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Similar to the pmu, the general register files contain a lot of different
setting bits grouped into general registers, but also some somewhat special
entities like the controls for some phy-blocks or the io-voltage control.
To be able to move these blocks under the grf node where they actually
belong, make it a simple-mfd.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 31f7e20..bc57232 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -745,7 +745,7 @@
 	};
 
 	grf: syscon at ff770000 {
-		compatible = "rockchip,rk3288-grf", "syscon";
+		compatible = "rockchip,rk3288-grf", "syscon", "simple-mfd";
 		reg = <0xff770000 0x1000>;
 	};
 
-- 
2.6.4
