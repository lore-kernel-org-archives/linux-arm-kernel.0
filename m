From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 21 Jun 2017 13:43:10 +0200
Subject: [RESEND PATCH v5 10/16] ARM: dts: zynq: Add generic compatible
 string for I2C EEPROM
In-Reply-To: <20170615185418.13980-11-javier@dowhile0.org>
References: <20170615185418.13980-1-javier@dowhile0.org>
 <20170615185418.13980-11-javier@dowhile0.org>
Message-ID: <b22a7db6-7daf-b5c1-3978-cdc699723e30@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.6.2017 20:54, Javier Martinez Canillas wrote:
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
>  arch/arm/boot/dts/zynq-zc702.dts | 2 +-
>  arch/arm/boot/dts/zynq-zc706.dts | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
> index 0cdad2cc8b78..f8c840f7118f 100644
> --- a/arch/arm/boot/dts/zynq-zc702.dts
> +++ b/arch/arm/boot/dts/zynq-zc702.dts
> @@ -136,7 +136,7 @@
>  			#size-cells = <0>;
>  			reg = <2>;
>  			eeprom at 54 {
> -				compatible = "at,24c08";
> +				compatible = "atmel,24c08";
>  				reg = <0x54>;
>  			};
>  		};
> diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc706.dts
> index ad4bb06dba25..76492be4a912 100644
> --- a/arch/arm/boot/dts/zynq-zc706.dts
> +++ b/arch/arm/boot/dts/zynq-zc706.dts
> @@ -92,7 +92,7 @@
>  			#size-cells = <0>;
>  			reg = <2>;
>  			eeprom at 54 {
> -				compatible = "at,24c08";
> +				compatible = "atmel,24c08";
>  				reg = <0x54>;
>  			};
>  		};
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
