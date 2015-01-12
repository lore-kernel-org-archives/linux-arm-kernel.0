From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 12 Jan 2015 10:23:04 +0100
Subject: [RFC 2/3] ARM: dts: Specify MSHC realistic clocks and use frequency
 scaling
In-Reply-To: <1421054585-9032-1-git-send-email-k.kozlowski@samsung.com>
References: <1421054585-9032-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1421054585-9032-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lower the dw_mmc host clock from 400 MHz to 100 MHz because there are a
lot of MMC errors above 100 MHz.

Enable frequency scaling to reduce energy consumption. In idle this
reduced energy consumption by 2.6% (from 119.5 mA to 116.4 mA).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4412-trats2.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 29231b452643..21f1236ae979 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -558,7 +558,9 @@
 		non-removable;
 		card-detect-delay = <200>;
 		vmmc-supply = <&vemmc_reg>;
-		clock-frequency = <400000000>;
+		clock-frequency = <100000000>;
+		clock-freq-min-max = <400000 100000000>;
+		frequency-scaling;
 		samsung,dw-mshc-ciu-div = <0>;
 		samsung,dw-mshc-sdr-timing = <2 3>;
 		samsung,dw-mshc-ddr-timing = <1 2>;
-- 
1.9.1
