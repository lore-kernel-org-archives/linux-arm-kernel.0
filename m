From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 27 Nov 2013 12:15:52 +0100
Subject: [PATCH 03/04] ARM: shmobile: Genmai I2C-over-GPIO support
In-Reply-To: <20131127082805.20015.82680.sendpatchset@w520>
References: <20131127082736.20015.21303.sendpatchset@w520>
 <20131127082805.20015.82680.sendpatchset@w520>
Message-ID: <2757102.StIMV2khe5@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

Thank you for the patch.

On Wednesday 27 November 2013 17:28:05 Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add support for the Genmai I2C bus hooked up to P1_5 and P1_4 using
> the i2c-gpio driver. On the bus sits a 24c128 EEPRROM.

Is this a temporary workaround until we get a proper I2C controller driver, or 
is the EEPROM really hooked up to pins that are not wired to a hardware I2C 
controller ?

> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/arm/boot/dts/r7s72100-genmai-reference.dts |   18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> --- 0008/arch/arm/boot/dts/r7s72100-genmai-reference.dts
> +++ work/arch/arm/boot/dts/r7s72100-genmai-reference.dts	2013-11-27
> 15:51:31.000000000 +0900 @@ -39,4 +39,22 @@
>  			gpios = <&port4 11 GPIO_ACTIVE_LOW>;
>  		};
>  	};
> +
> +	i2c at 0 {
> +		compatible = "i2c-gpio";
> +		gpios = <&port1 5 GPIO_ACTIVE_HIGH /* sda */
> +			 &port1 4 GPIO_ACTIVE_HIGH /* scl */
> +			>;
> +		i2c-gpio,sda-open-drain;
> +		i2c-gpio,scl-open-drain;
> +		i2c-gpio,delay-us = <5>;	/* ~100 kHz */
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		eeprom: 24c128 at 50 {
> +			compatible = "at,24c128";
> +			reg = <0x50>;
> +		};
> +	};
> +
>  };
-- 
Regards,

Laurent Pinchart
