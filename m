From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 23 Nov 2012 20:57:33 -0500
Subject: [PATCH 1/3] ARM: kirkwood: Add support second I2C bus and RTC
 on OpenBlocks A6
In-Reply-To: <1353619812-2195-1-git-send-email-iwamatsu@nigauri.org>
References: <1353619812-2195-1-git-send-email-iwamatsu@nigauri.org>
Message-ID: <20121124015733.GN15800@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2012 at 06:30:10AM +0900, Nobuhiro Iwamatsu wrote:
> OpenBlocks A6 uses second I2C with RTC of s35390a.
> This supports them.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

You probably want to make your kirkwood-6282.dtsi "second i2c" patch the
first of this series and then include the dtsi in this dts file.

Other than that, this looks fine.  Since I'm pulling everything in right
now, I'll go ahead and fix it up on my end.

thx,

Jason.

> ---
>  arch/arm/boot/dts/kirkwood-openblocks_a6.dts |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
> index 9a2606c..3f055ad 100644
> --- a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
> +++ b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
> @@ -35,5 +35,14 @@
>  			nr-ports = <1>;
>  			status = "okay";
>  		};
> +
> +		i2c at 11100 {
> +			status = "okay";
> +
> +			s35390a: s35390a at 30 {
> +				compatible = "s35390a";
> +				reg = <0x30>;
> +			};
> +		};
>  	};
>  };
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
