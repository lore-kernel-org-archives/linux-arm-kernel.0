From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Tue, 10 Jul 2018 13:31:47 -0300
Subject: [PATCH v4 5/6] ARM: dts: imx53: Add a label for the PMU node
In-Reply-To: <1531240308-24798-1-git-send-email-fabio.estevam@nxp.com>
References: <1531240308-24798-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <1531240308-24798-5-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a label for the PMU node so that the board dts may be able to
pass the 'secure-reg-access' property like this:

&pmu {
	secure-reg-access;
};

This also makes it consistent with the PMU node in imx6qdl.dtsi

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Tested-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
Changes since v3:
- None

 arch/arm/boot/dts/imx53.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 3fd553c..6386185 100644
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
