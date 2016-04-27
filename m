From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 28 Apr 2016 09:07:02 +1000
Subject: [PATCH] arm64: dts: r8a7795: Don't disable referenced optional scif
 clock
In-Reply-To: <cover.1461798058.git.horms+renesas@verge.net.au>
References: <cover.1461798058.git.horms+renesas@verge.net.au>
Message-ID: <f5515f9cdff136dc32517d4b81fe2b9091237b4a.1461798058.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

clk_get() on a disabled clock node will return -EPROBE_DEFER, which can
cause drivers to be deferred forever if such clocks are referenced in
their devices' clocks properties.

Update the disabled external scif clock node so that it
is not disabled to prevent this.

Reported-by: J?rg Billeter <j@bitron.ch>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[simon: fix for v4.6 extracted from a larger patch targeted at v4.7]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index a7315ebe3883..706d2426024f 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -120,7 +120,6 @@
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <0>;
-		status = "disabled";
 	};
 
 	soc {
-- 
2.7.0.rc3.207.g0ac5344
