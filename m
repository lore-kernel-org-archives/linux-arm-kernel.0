From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Thu, 18 Jan 2018 18:43:45 +0100
Subject: [PATCH 3/3] ARM: dts: imx53: PPD: Enable secure-reg-access
In-Reply-To: <20180118174345.26620-1-sebastian.reichel@collabora.co.uk>
References: <20180118174345.26620-1-sebastian.reichel@collabora.co.uk>
Message-ID: <20180118174345.26620-4-sebastian.reichel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Senna Tschudin <peter.senna@collabora.com>

Add secure-reg-access on PPD device tree to enable PMU and
hardware counters for perf.

Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 arch/arm/boot/dts/imx53-ppd.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx53-ppd.dts b/arch/arm/boot/dts/imx53-ppd.dts
index 80224fa995f9..d8e001f02b05 100644
--- a/arch/arm/boot/dts/imx53-ppd.dts
+++ b/arch/arm/boot/dts/imx53-ppd.dts
@@ -48,6 +48,12 @@
 	model = "General Electric CS ONE";
 	compatible = "ge,imx53-cpuvo", "fsl,imx53";
 
+	soc {
+		pmu {
+			secure-reg-access;
+		};
+	};
+
 	aliases {
 		spi0 = &cspi;
 		spi1 = &ecspi1;
-- 
2.15.1
