From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 21 Jun 2017 13:43:16 +0200
Subject: [RESEND PATCH v5 11/16] arm64: zynqmp: Add generic compatible
 string for I2C EEPROM
In-Reply-To: <20170615185418.13980-12-javier@dowhile0.org>
References: <20170615185418.13980-1-javier@dowhile0.org>
 <20170615185418.13980-12-javier@dowhile0.org>
Message-ID: <e64ce8be-599a-5fc5-3194-92aac574173c@xilinx.com>
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
>  arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
> index ef1b9e573af0..53907b7a7fd9 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
> @@ -55,7 +55,7 @@
>  	status = "okay";
>  	clock-frequency = <400000>;
>  	eeprom at 54 {
> -		compatible = "at,24c64";
> +		compatible = "atmel,24c64";
>  		reg = <0x54>;
>  	};
>  };
> @@ -64,7 +64,7 @@
>  	status = "okay";
>  	clock-frequency = <400000>;
>  	eeprom at 55 {
> -		compatible = "at,24c64";
> +		compatible = "atmel,24c64";
>  		reg = <0x55>;
>  	};
>  };
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
