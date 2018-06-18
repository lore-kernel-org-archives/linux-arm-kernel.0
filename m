From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 18 Jun 2018 10:52:18 -0300
Subject: [PATCH 2/3] ARM: dts: imx53: Add a label for the PMU node
In-Reply-To: <1529329939-14117-1-git-send-email-festevam@gmail.com>
References: <1529329939-14117-1-git-send-email-festevam@gmail.com>
Message-ID: <1529329939-14117-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Add a label for the PMU node so that the board dts may be able to
pass the 'secure-reg-access' property like this:

&pmu {
	secure-reg-access;
};

This also makes it consistent with the PMU node in imx6qdl.dtsi

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx53.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index a70fbf4..263bd39f 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -113,7 +113,7 @@
 		};
 	};
 
-	pmu {
+	pmu: pmu {
 		compatible = "arm,cortex-a8-pmu";
 		interrupt-parent = <&tzic>;
 		interrupts = <77>;
-- 
2.7.4
