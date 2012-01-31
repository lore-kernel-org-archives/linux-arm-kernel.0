From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 31 Jan 2012 20:20:25 +0530
Subject: [PATCH] ARM: Exynos4: Add cpu-offset property in gic device tree node
Message-ID: <1328021425-4233-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 'ARM: gic: allow GIC to support non-banked setups' (db0d4db22a78d31c)
requires a cpu-offset property to be specified for non-banked gic controllers,
which is the case for Exynos4.

Reported-by: Karol Lewandowski <k.lewandowski@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
This patch solves the issue of boot failure with SMP enabled kernel for
Exynos4 device tree enabled machine.

 arch/arm/boot/dts/exynos4210.dtsi |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 63d7578..a1dd2ee 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -29,6 +29,7 @@
 		compatible = "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
 		interrupt-controller;
+		cpu-offset = <0x8000>;
 		reg = <0x10490000 0x1000>, <0x10480000 0x100>;
 	};
 
-- 
1.6.6.rc2
