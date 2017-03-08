From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Wed, 08 Mar 2017 13:54:09 +0900
Subject: [PATCH v5 2/5] arm: dts: Add the burst and esc clock frequency
 properties to DSI node
In-Reply-To: <1488948852-5380-1-git-send-email-hoegeun.kwon@samsung.com>
References: <1488948852-5380-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170308045502epcas1p26f050caaf6eeb79bc88afcb0e2eaeac2@epcas1p2.samsung.com>
Message-ID: <1488948852-5380-3-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the burst and esc clock frequency properties to the parent (DSI node).
Currently the clock is parsed from the port node, while it should be
taken from the dsi node.

Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Andi Shyti <andi.shyti@samsung.com>
---
 arch/arm/boot/dts/exynos3250-rinato.dts | 2 ++
 arch/arm/boot/dts/exynos4210-trats.dts  | 2 ++
 arch/arm/boot/dts/exynos4412-trats2.dts | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index 548413e..c9f191c 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -215,6 +215,8 @@
 &dsi_0 {
 	vddcore-supply = <&ldo6_reg>;
 	vddio-supply = <&ldo6_reg>;
+	samsung,burst-clock-frequency = <250000000>;
+	samsung,esc-clock-frequency = <20000000>;
 	samsung,pll-clock-frequency = <24000000>;
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index 0ca1b4d..1743ca8 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -197,6 +197,8 @@
 &dsi_0 {
 	vddcore-supply = <&vusb_reg>;
 	vddio-supply = <&vmipi_reg>;
+	samsung,burst-clock-frequency = <500000000>;
+	samsung,esc-clock-frequency = <20000000>;
 	samsung,pll-clock-frequency = <24000000>;
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 41ecd6d..82221a0 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -385,6 +385,8 @@
 &dsi_0 {
 	vddcore-supply = <&ldo8_reg>;
 	vddio-supply = <&ldo10_reg>;
+	samsung,burst-clock-frequency = <500000000>;
+	samsung,esc-clock-frequency = <20000000>;
 	samsung,pll-clock-frequency = <24000000>;
 	status = "okay";
 
-- 
1.9.1
