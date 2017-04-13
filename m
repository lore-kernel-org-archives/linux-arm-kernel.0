From: peda@axentia.se (Peter Rosin)
Date: Thu, 13 Apr 2017 22:43:25 +0200
Subject: [PATCH v2 05/22] ARM: dts: at91: Add generic compatible string
 for I2C EEPROM
In-Reply-To: <20170413182839.25381-6-javier@osg.samsung.com>
References: <20170413182839.25381-1-javier@osg.samsung.com>
 <20170413182839.25381-6-javier@osg.samsung.com>
Message-ID: <869a0f44-6c97-2109-776b-6da9b86c732a@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-04-13 20:28, Javier Martinez Canillas wrote:
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
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> 
> Changes in v2: None
> 
>  arch/arm/boot/dts/at91-linea.dtsi   | 2 +-
>  arch/arm/boot/dts/at91-tse850-3.dts | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91-linea.dtsi b/arch/arm/boot/dts/at91-linea.dtsi
> index 0721c8472509..9a19080fd3bf 100644
> --- a/arch/arm/boot/dts/at91-linea.dtsi
> +++ b/arch/arm/boot/dts/at91-linea.dtsi
> @@ -31,7 +31,7 @@
>  	status = "okay";
>  
>  	eeprom at 51 {
> -		compatible = "st,24c64";
> +		compatible = "st,24c64","atmel,24c64";
>  		reg = <0x51>;
>  		pagesize = <32>;
>  	};
> diff --git a/arch/arm/boot/dts/at91-tse850-3.dts b/arch/arm/boot/dts/at91-tse850-3.dts
> index 7a68805a4eb5..6f005c14a6b0 100644
> --- a/arch/arm/boot/dts/at91-tse850-3.dts
> +++ b/arch/arm/boot/dts/at91-tse850-3.dts
> @@ -239,7 +239,7 @@
>  	};
>  
>  	eeprom at 50 {
> -		compatible = "nxp,24c02";
> +		compatible = "nxp,24c02","atmel,24c02";
>  		reg = <0x50>;
>  		pagesize = <16>;
>  	};
> 

Sure, in principle. But not having a space after the commas is a real OCD
trigger for me. My spine is rotating... :-)

Anyway, with those whitespace fixes (and without them too, but please):
Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
peda
