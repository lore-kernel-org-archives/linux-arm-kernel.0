From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 4 Jan 2012 12:50:27 -0700
Subject: [PATCH 3/6] ARM: dt: tegra30.dtsi: Reformat gpio's interrupts
 property
In-Reply-To: <1325702378-20863-3-git-send-email-swarren@nvidia.com>
References: <1325702378-20863-1-git-send-email-swarren@nvidia.com>
 <1325702378-20863-3-git-send-email-swarren@nvidia.com>
Message-ID: <20120104195027.GE15503@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2012 at 11:39:35AM -0700, Stephen Warren wrote:
> The new content matches tegra20.dtsi, and is < 80 columns.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  arch/arm/boot/dts/tegra30.dtsi |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
> index ee7db98..e5d1406 100644
> --- a/arch/arm/boot/dts/tegra30.dtsi
> +++ b/arch/arm/boot/dts/tegra30.dtsi
> @@ -55,7 +55,13 @@
>  	gpio: gpio at 6000d000 {
>  		compatible = "nvidia,tegra30-gpio", "nvidia,tegra20-gpio";
>  		reg = < 0x6000d000 0x1000 >;
> -		interrupts = < 0 32 0x04 0 33 0x04 0 34 0x04 0 35 0x04 0 55 0x04 0 87 0x04 0 89 0x04 >;
> +		interrupts = < 0 32 0x04
> +			       0 33 0x04
> +			       0 34 0x04
> +			       0 35 0x04
> +			       0 55 0x04
> +			       0 87 0x04
> +			       0 89 0x04 >;

Nit: I often find the following form convenient (even if it doesn't change the data generation):

		interrupts = < 0 32 0x04 >,
			     < 0 33 0x04 >,
			     < 0 34 0x04 >,
			     < 0 35 0x04 >,
			     < 0 55 0x04 >,
			     < 0 87 0x04 >,
			     < 0 89 0x04 >;

Otherwise:

Acked-by: Grant Likely <grant.likely@secretlab.ca>

>  		#gpio-cells = <2>;
>  		gpio-controller;
>  	};
> -- 
> 1.7.0.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
