From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Mon, 19 Mar 2018 22:41:30 +0100
Subject: [PATCH 2/2] ARM: dts: armada388-clearfog: add SFP module support
In-Reply-To: <E1eqhha-0004l3-Rd@rmk-PC.armlinux.org.uk> (Russell King's
 message of "Tue, 27 Feb 2018 16:02:02 +0000")
References: <20180227160135.GU9418@n2100.armlinux.org.uk>
 <E1eqhha-0004l3-Rd@rmk-PC.armlinux.org.uk>
Message-ID: <87efkfyc8l.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,
 
 On mar., f?vr. 27 2018, Russell King <rmk+kernel@arm.linux.org.uk> wrote:

> Add SFP module support for Clearfog using the SFP phylink support.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>


Applied on mvebu/dt with the tested-by flags

Thanks,

Gregory

> ---
>  arch/arm/boot/dts/armada-388-clearfog.dtsi | 45 ++++++++----------------------
>  1 file changed, 12 insertions(+), 33 deletions(-)
>
> diff --git a/arch/arm/boot/dts/armada-388-clearfog.dtsi b/arch/arm/boot/dts/armada-388-clearfog.dtsi
> index 0e3b1f140e6d..a44bf20ab7f8 100644
> --- a/arch/arm/boot/dts/armada-388-clearfog.dtsi
> +++ b/arch/arm/boot/dts/armada-388-clearfog.dtsi
> @@ -117,6 +117,16 @@
>  			};
>  		};
>  	};
> +
> +	sfp: sfp {
> +		compatible = "sff,sfp";
> +		i2c-bus = <&i2c1>;
> +		los-gpio = <&expander0 12 GPIO_ACTIVE_HIGH>;
> +		mod-def0-gpio = <&expander0 15 GPIO_ACTIVE_LOW>;
> +		tx-disable-gpio = <&expander0 14 GPIO_ACTIVE_HIGH>;
> +		tx-fault-gpio = <&expander0 13 GPIO_ACTIVE_HIGH>;
> +		maximum-power-milliwatt = <2000>;
> +	};
>  };
>  
>  &eth1 {
> @@ -133,13 +143,10 @@
>  	bm,pool-long = <3>;
>  	bm,pool-short = <1>;
>  	buffer-manager = <&bm>;
> +	managed = "in-band-status";
>  	phy-mode = "sgmii";
> +	sfp = <&sfp>;
>  	status = "okay";
> -
> -	fixed-link {
> -		speed = <1000>;
> -		full-duplex;
> -	};
>  };
>  
>  &i2c0 {
> @@ -208,34 +215,6 @@
>  			output-low;
>  			line-name = "m.2 devslp";
>  		};
> -		sfp_los {
> -			/* SFP loss of signal */
> -			gpio-hog;
> -			gpios = <12 GPIO_ACTIVE_HIGH>;
> -			input;
> -			line-name = "sfp-los";
> -		};
> -		sfp_tx_fault {
> -			/* SFP laser fault */
> -			gpio-hog;
> -			gpios = <13 GPIO_ACTIVE_HIGH>;
> -			input;
> -			line-name = "sfp-tx-fault";
> -		};
> -		sfp_tx_disable {
> -			/* SFP transmit disable */
> -			gpio-hog;
> -			gpios = <14 GPIO_ACTIVE_HIGH>;
> -			output-low;
> -			line-name = "sfp-tx-disable";
> -		};
> -		sfp_mod_def0 {
> -			/* SFP module present */
> -			gpio-hog;
> -			gpios = <15 GPIO_ACTIVE_LOW>;
> -			input;
> -			line-name = "sfp-mod-def0";
> -		};
>  	};
>  
>  	/* The MCP3021 supports standard and fast modes */
> -- 
> 2.7.4
>

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
