From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 04 Jan 2017 11:37:06 +0100
Subject: [PATCH] ARM: dts: armada388-clearfog: fix SPI flash #size-cells
In-Reply-To: <E1cO41M-0007xc-Id@rmk-PC.armlinux.org.uk> (Russell King's
 message of "Mon, 02 Jan 2017 14:55:32 +0000")
References: <E1cO41M-0007xc-Id@rmk-PC.armlinux.org.uk>
Message-ID: <87a8b7f6wd.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,
 
 On lun., janv. 02 2017, Russell King <rmk+kernel@armlinux.org.uk> wrote:

> The SPI flash #size-cells is specified in the binding documentation to
> have value 1, but we were setting it to zero.  This wasn't causing any
> problem as we do not list any partitions, but it's worth specifying
> correctly if we're going to specify it at all.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Applied on mvebu/dt

Thanks,

Gregory

> ---
>  arch/arm/boot/dts/armada-388-clearfog.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/armada-388-clearfog.dts b/arch/arm/boot/dts/armada-388-clearfog.dts
> index 71ce201c903e..3e7c3a6237c3 100644
> --- a/arch/arm/boot/dts/armada-388-clearfog.dts
> +++ b/arch/arm/boot/dts/armada-388-clearfog.dts
> @@ -437,7 +437,7 @@
>  
>  	spi-flash at 0 {
>  		#address-cells = <1>;
> -		#size-cells = <0>;
> +		#size-cells = <1>;
>  		compatible = "w25q32", "jedec,spi-nor";
>  		reg = <0>; /* Chip select 0 */
>  		spi-max-frequency = <3000000>;
> -- 
> 2.7.4
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
