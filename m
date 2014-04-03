From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu, 3 Apr 2014 07:19:57 +0200
Subject: [PATCH 1/2] ARM: socfpga: dts: add eeprom, lcd, and rtc on i2c0
In-Reply-To: <1396492834-26035-1-git-send-email-dinguyen@altera.com>
References: <1396492834-26035-1-git-send-email-dinguyen@altera.com>
Message-ID: <20140403051957.GB12170@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Wed, Apr 02, 2014 at 09:40:33PM -0500, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> The Altera Cyclone5 and Arria5 devkit has an EEPROM, LCD and a RTC on the
> board. This patch adds support for them.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> ---
>  arch/arm/boot/dts/socfpga_arria5_socdk.dts   |   22 ++++++++++++++++++++++
>  arch/arm/boot/dts/socfpga_cyclone5_socdk.dts |   22 ++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/socfpga_arria5_socdk.dts b/arch/arm/boot/dts/socfpga_arria5_socdk.dts
> index 88e4a8e..674dcf8 100644
> --- a/arch/arm/boot/dts/socfpga_arria5_socdk.dts
> +++ b/arch/arm/boot/dts/socfpga_arria5_socdk.dts
> @@ -59,3 +59,25 @@
>  	rxdv-skew-ps = <0>;
>  	rxc-skew-ps = <2000>;
>  };
> +
> +&i2c0 {
> +	status = "okay";
> +	lcd: lcd at 28 {
> +		compatible = "newhaven,nhd-0216k3z-nsw-bbw";
> +		reg = <0x28>;
> +		height = <2>;
> +		width = <16>;
> +		brightness = <8>;
> +	};

I would prefer if we have the display in an extra patch.
This seems simple and okay, but everybody should get a chance to at least
discuss this new binding+driver instead of just "hiding" it in this patch.

> +
> +	eeprom at 51 {
> +		compatible = "atmel,24c32";
> +		reg = <0x51>;
> +		pagesize = <32>;
> +	};
> +
> +	rtc at 68 {
> +		compatible = "dallas,ds1339";
> +		reg = <0x68>;
> +	};
> +};
> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
> index 5e9445a..0d85021 100644
> --- a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
> +++ b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
> @@ -52,3 +52,25 @@
>  	rxdv-skew-ps = <0>;
>  	rxc-skew-ps = <2000>;
>  };
> +
> +&i2c0 {
> +	status = "okay";
> +	lcd: lcd at 28 {
> +		compatible = "newhaven,nhd-0216k3z-nsw-bbw";
> +		reg = <0x28>;
> +		height = <2>;
> +		width = <16>;
> +		brightness = <8>;
> +	};
> +
> +	eeprom at 51 {
> +		compatible = "atmel,24c32";
> +		reg = <0x51>;
> +		pagesize = <32>;
> +	};
> +
> +	rtc at 68 {
> +		compatible = "dallas,ds1339";
> +		reg = <0x68>;
> +	};
> +};
> -- 
> 1.7.9.5
> 
> 

The rest looks okay.

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
