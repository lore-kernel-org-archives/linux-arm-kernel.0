From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 27 Aug 2016 18:33:10 +0200
Subject: [PATCH v2 3/3] ARM: dts: Set the clock rate for DREX block
 800Mhz on exynos5422-odroidxu3
In-Reply-To: <1472108238-24309-4-git-send-email-cw00.choi@samsung.com>
References: <1472108238-24309-1-git-send-email-cw00.choi@samsung.com>
 <1472108238-24309-4-git-send-email-cw00.choi@samsung.com>
Message-ID: <20160827163310.GA8616@kozik-book>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2016 at 03:57:18PM +0900, Chanwoo Choi wrote:
> This patch sets the clock rate for DREX (DRAM Express) block
> on exynos5422-odroidxu3 board. In the exynos5422 TRM,
> DRAM clocks use BPLL clock and CMU_CDREX generates
> the 800MHz DRAM clock.
> 

>From the commit message I don't get two things:
1. Why setting this on XU3-family of boards, not all 542x/5800?
2. Why this is needed? The commit msg lacks the answer to the "why".

> [clk_summary on exynos5422-odroidxu3 board]
> fout_bpll                             0            0   800000000          0 0
>     mout_bpll                          0            0   800000000          0 0
>        mout_mclk_cdrex                 0            0   800000000          0 0
>           dout_pclk_core_mem           0            0   200000000          0 0
>           dout_sclk_cdrex              0            0   800000000          0 0
>

What is the purpose of this dump of clk_summary? Is it a state before or
after the change? After it is quite obvious that it should have
800MHz...

Best regards,
Krzysztof

> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> index d56253049ccb..fd3f67c72039 100644
> --- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> @@ -229,6 +229,11 @@
>  	status = "okay";
>  };
>  
> +&clock {
> +	assigned-clocks = <&clock CLK_DOUT_SCLK_CDREX>;
> +	assigned-clock-rates = <800000000>;
> +};
> +
>  &clock_audss {
>  	assigned-clocks = <&clock_audss EXYNOS_MOUT_AUDSS>,
>  			<&clock_audss EXYNOS_MOUT_I2S>,
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
