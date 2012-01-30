From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 30 Jan 2012 11:58:14 -0700
Subject: [PATCH 3/3] ARM: at91: sam9g20 & sam9g45 add spi DT support
In-Reply-To: <1327937271-23668-3-git-send-email-plagnioj@jcrosoft.com>
References: <1327937271-23668-1-git-send-email-plagnioj@jcrosoft.com>
 <1327937271-23668-3-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20120130185814.GQ28397@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2012 at 04:27:51PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> at91sam9m10g45ek:
> 	add dataflash support
> usb_a9g20:
> 	add mmc spi support
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: devicetree-discuss at lists.ozlabs.org
> ---
> diff --git a/arch/arm/boot/dts/usb_a9g20.dts b/arch/arm/boot/dts/usb_a9g20.dts
> index e6c7970..1dfb7a9 100644
> --- a/arch/arm/boot/dts/usb_a9g20.dts
> +++ b/arch/arm/boot/dts/usb_a9g20.dts
> @@ -84,6 +84,17 @@
>  				status = "okay";
>  			};
>  
> +			spi1: spi at fffcc000 {
> +				status = "okay";
> +				mmc-slot at 0 {
> +					compatible = "mmc-spi-slot";
> +					ncs-gpio = <&pioB 3 0>;
> +					gpios = <&pioC 4 0   /* CD */
> +						>;

Drop the above ncs-gpios line, but otherwise:

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> +					voltage-ranges = <3200 3400>;
> +					spi-max-frequency = <20000000>;
> +				};
> +			};
>  		};
>  	};
>  };
