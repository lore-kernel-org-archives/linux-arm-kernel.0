From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 21 Dec 2014 13:38:34 +0100
Subject: [PATCH] ARM: dts: add gpio_poweroff support for Iomega ix2-200
In-Reply-To: <1418236841-15277-1-git-send-email-richard.kunze@web.de>
References: <1418236841-15277-1-git-send-email-richard.kunze@web.de>
Message-ID: <20141221123834.GB29218@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 10, 2014 at 07:40:41PM +0100, Richard Kunze wrote:
> Iomega ix2-200 can be powered off via GPIO 0 pin 17,
> this patch wires up the gpio-poweroff driver to do it.
> 
> Signed-off-by: Richard Kunze <richard.kunze@web.de>

Hi Richard

Added to mvebu/dt

      Andrew

> ---
>  arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts b/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
> index 05291f3..7aeddcd 100644
> --- a/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
> +++ b/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
> @@ -169,6 +169,10 @@
>  			gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
>  		};
>  	};
> +	gpio-poweroff {
> +		compatible = "gpio-poweroff";
> +		gpios = <&gpio0 17 GPIO_ACTIVE_LOW>;
> +	};
>  };
>  
>  &nand {
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
