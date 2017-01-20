From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 20 Jan 2017 18:28:46 +0200
Subject: [PATCH 2/2] ARM: dts: exynos: Use correct mfc_pd async-bridge
 clock for Exynos5420
In-Reply-To: <1484864995-10679-2-git-send-email-javier@osg.samsung.com>
References: <1484864995-10679-1-git-send-email-javier@osg.samsung.com>
 <1484864995-10679-2-git-send-email-javier@osg.samsung.com>
Message-ID: <20170120162846.x766u3nzblqywggj@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 07:29:55PM -0300, Javier Martinez Canillas wrote:
> Commit 94aed538e032 ("ARM: dts: exynos: Add async-bridge clock to MFC
> power domain for Exynos5420") fixed an imprecise external abort error
> when the MFC registers were tried to be accessed and the needed clock
> for the asynchronous bridges were gated.
> 
> But according to the Exynos5420 manual the "Gating AXI clock for MFC"
> is not CLK_ACLK333 but CLK_MFC.
> 
> The end effect is the same because CLK_ACLK333 is a parent of CLK_MFC
> but the correct clock should be used instead.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
>  arch/arm/boot/dts/exynos5420.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Is this still needed?

Best regards,
Krzysztof

> 
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index 906a1a42a7ea..ffb148ea91d6 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -294,7 +294,7 @@
>  			reg = <0x10044060 0x20>;
>  			clocks = <&clock CLK_FIN_PLL>,
>  				 <&clock CLK_MOUT_USER_ACLK333>,
> -				 <&clock CLK_ACLK333>;
> +				 <&clock CLK_MFC>;
>  			clock-names = "oscclk", "clk0","asb0";
>  			#power-domain-cells = <0>;
>  		};
> -- 
> 2.7.4
> 
