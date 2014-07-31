From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 31 Jul 2014 13:45:56 +0200
Subject: [PATCHv2 4/5] clk: samsung: exynos5410: Add fixed rate clocks
In-Reply-To: <1406805732-17372-5-git-send-email-hsnaves@gmail.com>
References: <1406805732-17372-1-git-send-email-hsnaves@gmail.com>
 <1406805732-17372-5-git-send-email-hsnaves@gmail.com>
Message-ID: <53DA2C74.3010101@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(dropping linux-doc ML and Randy from Cc)

On 31/07/14 13:22, Humberto Silva Naves wrote:
> This implements the fixed rate clocks generated either inside or
> outside the SoC. It also adds a dt-binding constant for the
> sclk_hdmiphy clock, which shall be later used by other drivers,
> such as the DRM.
> 
> Since the external fixed rate clock fin_pll is now registered by
> the clk-exynos5410 file, the bindings with the device tree file have
> changed. It is no longer needed to define fin_pll as a fixed clock,
> such as in:
> 
> 	fin_pll: xxti {
>   		compatible = "fixed-clock";
> 	  	clock-frequency = <24000000>;
> 	  	clock-output-names = "fin_pll";
> 	  	#clock-cells = <0>;
> 	};
> 
> The above lines should be replaced by the following lines:
> 
> 	fixed-rate-clocks {
> 		oscclk {
> 			compatible = "samsung,exynos5410-oscclk";
> 			clock-frequency = <24000000>;
> 		};
> 	};
> 
> This new form of binding was properly documented in the relevant
> documentation file.

Can you explain what is rationale behind this change ? Is it related to
suspend/resume ordering ?
Obviously it breaks the kernel/dtb compatibility. We should be moving
in opposite direction, i.e. completely remove the custom samsung fixed
rate clocks. I've tried to address this with patches [1], [2] but Tomasz
wasn't happy with them IIRC and I postponed work on that.

[1] http://www.spinics.net/lists/arm-kernel/msg333211.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/258490.html

--
Regards,
Sylwester
