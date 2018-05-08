From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Tue, 8 May 2018 14:44:03 +0300
Subject: [PATCH 8/8] arm64: tegra: Mark tcu as primary serial port on Tegra194
 P2888
In-Reply-To: <20180508114403.14499-1-mperttunen@nvidia.com>
References: <20180508114403.14499-1-mperttunen@nvidia.com>
Message-ID: <20180508114403.14499-9-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Tegra Combined UART is the proper primary serial port on P2888,
so use it.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
index 859ab5af17c1..95e2433984f7 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
@@ -10,7 +10,7 @@
 	aliases {
 		sdhci0 = "/cbb/sdhci at 3460000";
 		sdhci1 = "/cbb/sdhci at 3400000";
-		serial0 = &uartb;
+		serial0 = &tcu;
 		i2c0 = "/bpmp/i2c";
 		i2c1 = "/cbb/i2c at 3160000";
 		i2c2 = "/cbb/i2c at c240000";
-- 
2.16.1
