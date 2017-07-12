From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 12 Jul 2017 15:18:12 +0800
Subject: [PATCH v2] ARM: dts: imx7d-sdb: Set VLDO4 outpt to 2.8V for MIPI
 CSI/DSI
In-Reply-To: <20170701073911.7338-1-mindentropy@gmail.com>
References: <CAOMZO5A41QFoJsC2ST1kvpCOs3-unzHDrqXshHa=2ShWWCOyZg@mail.gmail.com>
 <20170701073911.7338-1-mindentropy@gmail.com>
Message-ID: <20170712071811.GI3172@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 01, 2017 at 01:09:11PM +0530, mindentropy wrote:
> From: Gautam Bhat <mindentropy@gmail.com>
> 
>  * According to mx7sabresd schematics the MIPI CSI/DSI voltage rails
>    should be 2.8V but the voltage provided is a maximum of 3.3V and
>    minimum of 1.8V. Providing such a higher voltage might damage the
>    peripherals and violates the schematic settings.

For such single paragraph commit log, the bullet and indentation are not
really necessary.  I edited it a bit and apply the patch.  Thanks.

Shawn

> 
> Signed-off-by: Gautam Bhat <mindentropy@gmail.com>
> ---
> Changes in v2:
>  - Added subject line according to convention
> 
>  arch/arm/boot/dts/imx7d-sdb.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
> index 5be01a1bf840..1da1f97ec342 100644
> --- a/arch/arm/boot/dts/imx7d-sdb.dts
> +++ b/arch/arm/boot/dts/imx7d-sdb.dts
> @@ -262,8 +262,8 @@
>  			};
>  
>  			vgen6_reg: vldo4 {
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
>  				regulator-always-on;
>  			};
>  		};
> -- 
> 2.11.0
> 
