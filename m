From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed, 14 Oct 2015 12:44:17 +0200
Subject: [PATCH v1 2/2] ARM: dts: exynos5250: Add clocks to DISP1 domain
In-Reply-To: <1444819457-27519-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1444819457-27519-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1444819457-27519-3-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds to the node of the DISP1 power domain the two clocks that need to
be reparented while the domain is powered off:
CLK_MOUT_ACLK200_DISP1_SUB and CLK_MOUT_ACLK300_DISP1_SUB.

Otherwise the state is unknown at power up and the mixer's clocks are
all messed up.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Link: http://lkml.kernel.org/g/561CDC33.7050103 at collabora.com
---

 arch/arm/boot/dts/exynos5250.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index b24610ea8c2a..88b9cf5f226f 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -130,6 +130,10 @@
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x100440A0 0x20>;
 		#power-domain-cells = <0>;
+		clocks = <&clock CLK_FIN_PLL>,
+			 <&clock CLK_MOUT_ACLK200_DISP1_SUB>,
+			 <&clock CLK_MOUT_ACLK300_DISP1_SUB>;
+		clock-names = "oscclk", "clk0", "clk1";
 	};
 
 	clock: clock-controller at 10010000 {
-- 
2.5.0
