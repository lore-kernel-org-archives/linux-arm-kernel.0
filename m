From: will.deacon@arm.com (Will Deacon)
Date: Mon, 26 Jan 2015 17:54:18 +0000
Subject: [PATCH 4/4] arm64: dts: add interrupt-affinity property to pmu node
 for juno
In-Reply-To: <1422294858-28100-1-git-send-email-will.deacon@arm.com>
References: <1422294858-28100-1-git-send-email-will.deacon@arm.com>
Message-ID: <1422294858-28100-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the Juno .dts robust against potential reordering of the CPU nodes
by adding an explicit interrupt-affinity property to the PMU node.

Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/boot/dts/arm/juno.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index 4ed9287aaef1..3542500137f0 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -112,6 +112,12 @@
 			     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&A53_0>,
+				     <&A57_0>,
+				     <&A57_1>,
+				     <&A53_1>,
+				     <&A53_2>,
+				     <&A53_3>;
 	};
 
 	/include/ "juno-clocks.dtsi"
-- 
2.1.4
