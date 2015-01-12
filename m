From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 12 Jan 2015 10:23:05 +0100
Subject: [RFC 3/3] ARM: dts: Use frequency scaling for MSHC
In-Reply-To: <1421054585-9032-1-git-send-email-k.kozlowski@samsung.com>
References: <1421054585-9032-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1421054585-9032-4-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable frequency scaling on MSHC to reduce energy consumption. In idle
this reduced energy consumption by 1.0% (from 27.16 mA to 26.89 mA).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos3250-rinato.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index e53f62f216ba..aad09109fdbc 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -493,6 +493,7 @@
 	vmmc-supply = <&ldo12_reg>;
 	clock-frequency = <100000000>;
 	clock-freq-min-max = <400000 100000000>;
+	frequency-scaling;
 	samsung,dw-mshc-ciu-div = <1>;
 	samsung,dw-mshc-sdr-timing = <0 1>;
 	samsung,dw-mshc-ddr-timing = <1 2>;
-- 
1.9.1
