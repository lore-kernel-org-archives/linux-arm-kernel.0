From: tushar.b@samsung.com (Tushar Behera)
Date: Wed, 11 Jun 2014 11:02:18 +0530
Subject: [PATCH 2/3] ARM: dts: Update the parent for Audss clocks in Exynos5420
In-Reply-To: <1402464739-19044-1-git-send-email-tushar.b@samsung.com>
References: <1402464739-19044-1-git-send-email-tushar.b@samsung.com>
Message-ID: <1402464739-19044-3-git-send-email-tushar.b@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently CLK_FOUT_EPLL was set as one of the parents of AUDSS mux.
As per the user manual, it should be CLK_MAU_EPLL.

The problem surfaced when the bootloader in Peach-pit board set
the EPLL clock as the parent of AUDSS mux. While booting the kernel,
we used to get a system hang during late boot if CLK_MAU_EPLL was
disabled.

Signed-off-by: Tushar Behera <tushar.b@samsung.com>
Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
Reported-by: Kevin Hilman <khilman@linaro.org>
---
 arch/arm/boot/dts/exynos5420.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index e385322..79e9119 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -167,7 +167,7 @@
 		compatible = "samsung,exynos5420-audss-clock";
 		reg = <0x03810000 0x0C>;
 		#clock-cells = <1>;
-		clocks = <&clock CLK_FIN_PLL>, <&clock CLK_FOUT_EPLL>,
+		clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MAU_EPLL>,
 			 <&clock CLK_SCLK_MAUDIO0>, <&clock CLK_SCLK_MAUPCM0>;
 		clock-names = "pll_ref", "pll_in", "sclk_audio", "sclk_pcm_in";
 	};
-- 
1.7.9.5
