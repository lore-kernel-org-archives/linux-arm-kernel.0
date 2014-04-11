From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 11 Apr 2014 18:00:53 +0200
Subject: [PATCH] ARM: dts: Fix PL330 MDMA clock assignment for Exynos4x12
In-Reply-To: <1397226211-29775-1-git-send-email-s.nawrocki@samsung.com>
References: <1397226211-29775-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <534811B5.10906@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

On 11.04.2014 16:23, Sylwester Nawrocki wrote:
> Exynos4212/4412 has different clock for the PL330 MDMA, ensure
> the clock is properly assigned for these newer SoCs.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>   arch/arm/boot/dts/exynos4x12.dtsi |    6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
> index c4a9306..19589c6 100644
> --- a/arch/arm/boot/dts/exynos4x12.dtsi
> +++ b/arch/arm/boot/dts/exynos4x12.dtsi
> @@ -243,4 +243,10 @@
>   		clock-names = "biu", "ciu";
>   		status = "disabled";
>   	};
> +
> +	amba {
> +		mdma at 12850000 {
> +			clocks = <&clock CLK_MDMA2>;
> +		};
> +	};
>   };
>

Since the ID for CLK_MDMA2 was added mistakenly, instead of reusing 
CLK_MDMA and it was not used by any device tree files anyway, I believe 
the better fix would be to simply change the clock definition in Exynos 
4 clock driver to use CLK_MDMA for both SoC families.

Best regards,
Tomasz
