From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 21 May 2016 23:23:46 +0200
Subject: [PATCH 1/3] arm64: dts: rockchip: add rk3368 io-domain core nodes
In-Reply-To: <1463865828-14583-1-git-send-email-heiko@sntech.de>
References: <1463865828-14583-1-git-send-email-heiko@sntech.de>
Message-ID: <1463865828-14583-2-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the core io-domain nodes to grf and pmugrf which individual
boards than just have to enable and add the necessary supplies to.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 4fb8484..58c2585 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -634,6 +634,11 @@
 	pmugrf: syscon at ff738000 {
 		compatible = "rockchip,rk3368-pmugrf", "syscon", "simple-mfd";
 		reg = <0x0 0xff738000 0x0 0x1000>;
+
+		pmu_io_domains: io-domains {
+			compatible = "rockchip,rk3368-pmu-io-voltage-domain";
+			status = "disabled";
+		};
 	};
 
 	cru: clock-controller at ff760000 {
@@ -647,6 +652,11 @@
 	grf: syscon at ff770000 {
 		compatible = "rockchip,rk3368-grf", "syscon", "simple-mfd";
 		reg = <0x0 0xff770000 0x0 0x1000>;
+
+		io_domains: io-domains {
+			compatible = "rockchip,rk3368-io-voltage-domain";
+			status = "disabled";
+		};
 	};
 
 	wdt: watchdog at ff800000 {
-- 
2.6.4
