From: robh@kernel.org (Rob Herring)
Date: Wed, 15 Feb 2017 17:40:29 -0600
Subject: [PATCH 8/8] ARM: sun8i: a33: Add the Mali OPPs
In-Reply-To: <2e4a4f3f2f584f65f3c2d5e78f589015c651198d.1486655917.git-series.maxime.ripard@free-electrons.com>
References: <cover.7101c7323e6f22e281ad70b93488cf44caca4ca0.1486655917.git-series.maxime.ripard@free-electrons.com>
 <2e4a4f3f2f584f65f3c2d5e78f589015c651198d.1486655917.git-series.maxime.ripard@free-electrons.com>
Message-ID: <20170215234029.3vfh25gxtvz44dsw@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 09, 2017 at 05:39:22PM +0100, Maxime Ripard wrote:
> The Mali GPU in the A33 has various operating frequencies used in the
> Allwinner BSP.
> 
> Add them to our DT.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/sun8i-a33.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
> index 043b1b017276..e1b0abfee42f 100644
> --- a/arch/arm/boot/dts/sun8i-a33.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a33.dtsi
> @@ -101,6 +101,22 @@
>  		status = "disabled";
>  	};
>  
> +	mali_opp_table: opp_table1 {

gpu-opp-table

> +		compatible = "operating-points-v2";
> +
> +		opp at 144000000 {
> +			opp-hz = /bits/ 64 <144000000>;
> +		};
> +
> +		opp at 240000000 {
> +			opp-hz = /bits/ 64 <240000000>;
> +		};
> +
> +		opp at 384000000 {
> +			opp-hz = /bits/ 64 <384000000>;
> +		};
> +	};
> +
>  	memory {
>  		reg = <0x40000000 0x80000000>;
>  	};
> @@ -282,6 +298,7 @@
>  
>  &mali {
>  	memory-region = <&display_pool>;
> +	operating-points-v2 = <&mali_opp_table>;
>  };
>  
>  &pio {
> -- 
> git-series 0.8.11
