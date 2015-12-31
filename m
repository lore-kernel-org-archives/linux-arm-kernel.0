From: edubezval@gmail.com (Eduardo Valentin)
Date: Thu, 31 Dec 2015 09:38:45 -0800
Subject: [PATCH] ARM: dts: omap3: Include missing bandgap data for
 ti-soc-thermal driver
In-Reply-To: <1451086345-3340-1-git-send-email-pali.rohar@gmail.com>
References: <1451086345-3340-1-git-send-email-pali.rohar@gmail.com>
Message-ID: <20151231173844.GD11863@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sat, Dec 26, 2015 at 12:32:25AM +0100, Pali Roh?r wrote:
> Driver for omap3 with documentation is there since v4.4-rc1.
> 
> Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>


> ---
>  arch/arm/boot/dts/omap34xx.dtsi |    5 +++++
>  arch/arm/boot/dts/omap36xx.dtsi |    5 +++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap34xx.dtsi b/arch/arm/boot/dts/omap34xx.dtsi
> index 4f6b2d5..c3f488f 100644
> --- a/arch/arm/boot/dts/omap34xx.dtsi
> +++ b/arch/arm/boot/dts/omap34xx.dtsi
> @@ -54,6 +54,11 @@
>  				#size-cells = <0>;
>  			};
>  		};
> +
> +		bandgap {
> +			reg = <0x48002524 0x4>;
> +			compatible = "ti,omap34xx-bandgap";
> +		};
>  	};
>  };
>  
> diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
> index 86253de..00f98c1 100644
> --- a/arch/arm/boot/dts/omap36xx.dtsi
> +++ b/arch/arm/boot/dts/omap36xx.dtsi
> @@ -86,6 +86,11 @@
>  				#size-cells = <0>;
>  			};
>  		};
> +
> +		bandgap {
> +			reg = <0x48002524 0x4>;
> +			compatible = "ti,omap36xx-bandgap";

Can you please already add on both cases

#thermal-sensor-cells = <0>;
?

This way we can already use them to define thermal zones. Of course,
that alone won't add the thermal zones. A separated patch would be
needed to add the thermal zone for OMAP3.

> +		};
>  	};
>  };
>  
> -- 
> 1.7.9.5
> 
