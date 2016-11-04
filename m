From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Fri, 04 Nov 2016 09:09:22 +0530
Subject: [PATCH 2/4] ARM: dts: exynos: Add SCU device node to exynos4.dtsi
In-Reply-To: <1478230764-13748-1-git-send-email-pankaj.dubey@samsung.com>
References: <1478230764-13748-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1478230764-13748-3-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos4 like other Cortex-A9 SoC's has a Snoop Control Unit(SCU)
and its SFR are used during SMP boot and S2R. Add SCU node to the device tree.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 5f034eb..6865ca9 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -78,6 +78,11 @@
 		reg = <0x10000000 0x100>;
 	};
 
+	scu: snoop-control-unit at 10500000 {
+		compatible = "arm,cortex-a9-scu";
+		reg = <0x10500000 0x2000>;
+	};
+
 	memory-controller at 12570000 {
 		compatible = "samsung,exynos4210-srom";
 		reg = <0x12570000 0x14>;
-- 
2.7.4
