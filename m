From: horms@verge.net.au (Simon Horman)
Date: Fri, 15 Sep 2017 10:05:30 +0200
Subject: [PATCH 4/8] ARM: dts: iwg22d: Enable SDHI0 controller
In-Reply-To: <1505322341-9480-5-git-send-email-chris.paterson2@renesas.com>
References: <1505322341-9480-1-git-send-email-chris.paterson2@renesas.com>
 <1505322341-9480-5-git-send-email-chris.paterson2@renesas.com>
Message-ID: <20170915080530.GH3924@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 13, 2017 at 06:05:37PM +0100, Chris Paterson wrote:
> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> 
> Enable the SDHI0 controller on iWave RZ/G1E carrier board.

...

> @@ -63,3 +88,15 @@
>  		micrel,led-mode = <1>;
>  	};
>  };
> +
> +&sdhi0 {
> +	pinctrl-0 = <&sdhi0_pins>;
> +	pinctrl-1 = <&sdhi0_pins_uhs>;
> +	pinctrl-names = "default", "state_uhs";
> +
> +	vmmc-supply = <&reg_3p3v>;
> +	vqmmc-supply = <&vccq_sdhi0>;
> +	cd-gpios = <&gpio6 6 GPIO_ACTIVE_LOW>;

I take that the absence of a wp-gpio means that that this is a ?SD slot.
Could you help me by documenting this correctly on
http://elinux.org/index.php?title=Renesas-MMC-Enabled-Speeds ?

For some reason I thought that SDHI0 wasn't exposed at all, so I guess
my reading of the documentation was incorrect.


I think you also want sd-uhs-sdr50 here too.
You can test it by removing the sd-uhs-sdr104 property.

> +	sd-uhs-sdr104;
> +	status = "okay";
> +};
> -- 
> 1.9.1
> 
