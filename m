From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 31 Mar 2016 15:48:45 +0200
Subject: [PATCH v2 4/5] arm64: dts: rockchip: make rk3368 grf syscons
 simple-mfds as well
In-Reply-To: <1459432126-6395-1-git-send-email-heiko@sntech.de>
References: <1459432126-6395-1-git-send-email-heiko@sntech.de>
Message-ID: <1459432126-6395-5-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The general register files do contain a lot of separate functions and
while some really are only registers with a lot of different 1-bit
settings, there are also a lot of them containing some bigger function
blocks. To be able to define these as sub-devices, make them simple-mfds.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: David Wu <david.wu@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 49d1191..6029310 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -556,7 +556,7 @@
 	};
 
 	pmugrf: syscon at ff738000 {
-		compatible = "rockchip,rk3368-pmugrf", "syscon";
+		compatible = "rockchip,rk3368-pmugrf", "syscon", "simple-mfd";
 		reg = <0x0 0xff738000 0x0 0x1000>;
 	};
 
@@ -569,7 +569,7 @@
 	};
 
 	grf: syscon at ff770000 {
-		compatible = "rockchip,rk3368-grf", "syscon";
+		compatible = "rockchip,rk3368-grf", "syscon", "simple-mfd";
 		reg = <0x0 0xff770000 0x0 0x1000>;
 	};
 
-- 
2.6.4
