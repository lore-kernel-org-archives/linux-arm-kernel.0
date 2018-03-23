From: dinguyen@kernel.org (Dinh Nguyen)
Date: Fri, 23 Mar 2018 08:56:17 -0500
Subject: [PATCH] arm: dts: socfpga: fix GIC PPI warning
In-Reply-To: <20180323092215.1307-1-pp@emlix.com>
References: <20180323092215.1307-1-pp@emlix.com>
Message-ID: <3b6eabf8-1d6b-7a58-03b1-3bff14c4127e@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/23/2018 04:22 AM, Philipp Puschmann wrote:
> Fixes the warning "GIC: PPI13 is secure or misconfigured" by
> changing the interrupt type from level_low to edge_raising
> 
> Signed-off-by: Philipp Puschmann <pp@emlix.com>
> ---
>  arch/arm/boot/dts/socfpga.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index 595eb4f1a761..e9417551d7ea 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -815,7 +815,7 @@
>  		timer at fffec600 {
>  			compatible = "arm,cortex-a9-twd-timer";
>  			reg = <0xfffec600 0x100>;
> -			interrupts = <1 13 0xf04>;
> +			interrupts = <1 13 0xf01>;
>  			clocks = <&mpu_periph_clk>;
>  		};

Applied, thanks!

Dinh
