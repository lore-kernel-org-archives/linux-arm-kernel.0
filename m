From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 31 Jul 2014 14:53:10 +0200
Subject: [PATCHv2 4/5] clk: samsung: exynos5410: Add fixed rate clocks
In-Reply-To: <1406805732-17372-5-git-send-email-hsnaves@gmail.com>
References: <1406805732-17372-1-git-send-email-hsnaves@gmail.com>
 <1406805732-17372-5-git-send-email-hsnaves@gmail.com>
Message-ID: <53DA3C36.1040206@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Humberto,

You can find my comments inline.

On 31.07.2014 13:22, Humberto Silva Naves wrote:
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

In general this is backwards. This Exynos-specific clock binding was
invented before generic fixed rate clock binding showed up and so few
drivers still use it to maintain DT ABI compatibility. However new
drivers are required to use the new generic binding and so does the one
for Exynos5410.

Best regards,
Tomasz
