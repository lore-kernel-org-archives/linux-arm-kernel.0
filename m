From: p.fedin@samsung.com (Pavel Fedin)
Date: Tue, 06 Oct 2015 11:24:00 +0300
Subject: [PATCH 2/2] ARM: dts: Use architected timer on Exynos 5410
In-Reply-To: <cover.1444119342.git.p.fedin@samsung.com>
References: <cover.1444119342.git.p.fedin@samsung.com>
Message-ID: <57f3491726014e3817bdf9988b1aa30436b45e00.1444119342.git.p.fedin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This switches the kernel to timer accesses using CP15, allowing to use
KVM virtualization.

Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
---
 arch/arm/boot/dts/exynos5410.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index d8de015..c14f100 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -138,6 +138,17 @@
 						<10 &gic 0 130 0>,
 						<11 &gic 0 131 0>;
 			};
+
+			arch_timer {
+				compatible = "arm,armv7-timer";
+				interrupt-parent = <&gic>;
+				interrupts = <1 13 0xf08>,
+						<1 14 0xf08>,
+						<1 11 0xf08>,
+						<1 10 0xf08>;
+				clock-frequency = <24000000>;
+			};
+
 		};
 
 		sysram at 02020000 {
-- 
2.4.4
