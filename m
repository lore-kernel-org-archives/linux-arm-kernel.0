From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Wed, 08 Mar 2017 13:54:08 +0900
Subject: [PATCH v5 1/5] arm64: dts: exynos: Add the burst and esc clock
 frequency properties to DSI node
In-Reply-To: <1488948852-5380-1-git-send-email-hoegeun.kwon@samsung.com>
References: <1488948852-5380-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170308045502epcas1p2b16df118e0ad91dbd2446687dc5ee843@epcas1p2.samsung.com>
Message-ID: <1488948852-5380-2-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the burst and esc clock frequency properties to the parent (DSI node).
Currently the clock is parsed from the port node, while it should be
taken from the dsi node.

Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Andi Shyti <andi.shyti@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index 6ce93a3..e31e20c 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -298,6 +298,8 @@
 	status = "okay";
 	vddcore-supply = <&ldo6_reg>;
 	vddio-supply = <&ldo7_reg>;
+	samsung,burst-clock-frequency = <512000000>;
+	samsung,esc-clock-frequency = <16000000>;
 	samsung,pll-clock-frequency = <24000000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&te_irq>;
-- 
1.9.1
