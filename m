From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Tue, 29 Jul 2014 14:33:05 +0200
Subject: [PATCH 4/4] ARM: dts: i.MX53: Add PMU DT entry
In-Reply-To: <20140729123256.13347.79778.stgit@localhost>
References: <20140729123256.13347.79778.stgit@localhost>
Message-ID: <20140729123305.13347.28161.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree node for PMU on i.MX53

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 arch/arm/boot/dts/imx53.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 6456a00..ab3afe0 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -101,6 +101,11 @@
 		interrupt-parent = <&tzic>;
 		ranges;
 
+		pmu {
+			compatible = "arm,cortex-a8-pmu";
+			interrupts = <77>;
+		};
+
 		sata: sata at 10000000 {
 			compatible = "fsl,imx53-ahci";
 			reg = <0x10000000 0x1000>;
