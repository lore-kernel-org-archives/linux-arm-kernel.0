From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 25 Sep 2014 23:58:37 +0200
Subject: [PATCH] ARM: dts: Specify default clocks for Exynos4 FIMC devices
In-Reply-To: <1410367054-30926-1-git-send-email-s.nawrocki@samsung.com>
References: <1410367054-30926-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <5424900D.2070709@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

On 10.09.2014 18:37, Sylwester Nawrocki wrote:
> The default mux and divider clocks are specified in device tree
> so that the FIMC devices in Exynos4210 and Exynos4x12 SoCs are
> clocked from recommended clock source and with maximum supported
> frequency. If needed these settings could be overrode in board
> specific dts files, however they are in practice optimal in most
> cases.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4210.dtsi |   16 ++++++++++++++++
>  arch/arm/boot/dts/exynos4x12.dtsi |   16 ++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
> index 807bb5b..0969d2e 100644
> --- a/arch/arm/boot/dts/exynos4210.dtsi
> +++ b/arch/arm/boot/dts/exynos4210.dtsi
> @@ -154,18 +154,30 @@
>  			samsung,pix-limits = <4224 8192 1920 4224>;
>  			samsung,mainscaler-ext;
>  			samsung,cam-if;
> +			assigned-clocks = <&clock CLK_MOUT_FIMC0>,
> +					<&clock CLK_SCLK_FIMC0>;
> +			assigned-clock-parents = <&clock CLK_SCLK_MPLL>;
> +			assigned-clock-rates = <0>, <160000000>;

I wonder whether such settings shouldn't really be set up on a per-board
basis.

As Daniel already pointed, we have cases when MPLL frequency differs
across boards, but we might also have boards that differ in power budget
and so having different desired operating frequencies for various IP blocks.

What do you think?

Best regards,
Tomasz
