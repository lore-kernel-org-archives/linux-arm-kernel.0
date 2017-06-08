From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 08 Jun 2017 19:04:45 +0200
Subject: [PATCH v5 04/20] ARM: dts: turris-omnia: Add generic compatible
 string for I2C EEPROM
In-Reply-To: <20170523133448.4794-5-javier@dowhile0.org> (Javier Martinez
 Canillas's message of "Tue, 23 May 2017 15:34:32 +0200")
References: <20170523133448.4794-1-javier@dowhile0.org>
 <20170523133448.4794-5-javier@dowhile0.org>
Message-ID: <87tw3qpg0i.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,
 
 On mar., mai 23 2017, Javier Martinez Canillas <javier@dowhile0.org> wrote:

> The at24 driver allows to register I2C EEPROM chips using different vendor
> and devices, but the I2C subsystem does not take the vendor into account
> when matching using the I2C table since it only has device entries.
>
> But when matching using an OF table, both the vendor and device has to be
> taken into account so the driver defines only a set of compatible strings
> using the "atmel" vendor as a generic fallback for compatible I2C devices.
>
> So add this generic fallback to the device node compatible string to make
> the device to match the driver using the OF device ID table.
>
> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>

Applied on mvebu/dt

Thanks,

Gregory

>
> ---
>
> Changes in v5: None
> Changes in v4:
> - Only use the atmel manufacturer in the compatible string instead of
>   keeping the deprecated ones (Rob Herring).
>
> Changes in v3: None
> Changes in v2: None
>
>  arch/arm/boot/dts/armada-385-turris-omnia.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> index 28eede180e4f..be16ce39fb3d 100644
> --- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
> +++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> @@ -171,7 +171,7 @@
>  			/* leds device (in STM32F0) at address 0x2b */
>  
>  			eeprom at 54 {
> -				compatible = "at,24c64";
> +				compatible = "atmel,24c64";
>  				reg = <0x54>;
>  
>  				/* The EEPROM contains data for bootloader.
> -- 
> 2.9.3
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
