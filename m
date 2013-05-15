From: nm@ti.com (Nishanth Menon)
Date: Wed, 15 May 2013 00:29:16 -0500
Subject: [PATCH v3] ARM:dts:omap4-panda:Update the LED support for the
 panda DTS
In-Reply-To: <1368541076-6854-1-git-send-email-dmurphy@ti.com>
References: <1368541076-6854-1-git-send-email-dmurphy@ti.com>
Message-ID: <20130515052916.GA15607@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

$subject - add a space?
s/ARM:dts:omap4-panda:Update/ARM: dts: omap4-panda: Update/ ?

On 09:17-20130514, Dan Murphy wrote:
> The GPIO for LED D1 on the omap4-panda a1-a3 rev and the omap4-panda-es
> are different.
> 
> A1-A3 = gpio_wk7
Thanks for fixing this - this is a key fix else, GPIO_7 which controls
VSEL for VDD_MPU on PandaBoard-ES will create all kind of ruckus (change
voltage on heartbeat)!
> ES = gpio_110
> 
> There is no change to LED D2
> 
> Abstract away the pinmux and the LED definitions for the two boards into
> the respective DTS files.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
[...]
> diff --git a/arch/arm/boot/dts/omap4-panda-es.dts b/arch/arm/boot/dts/omap4-panda-es.dts
> index f1d8c21..8d1ba03 100644
> --- a/arch/arm/boot/dts/omap4-panda-es.dts
> +++ b/arch/arm/boot/dts/omap4-panda-es.dts
> @@ -34,3 +34,43 @@
>  		0x5e 0x100	/* hdmi_sda.hdmi_sda INPUT | MODE 0 */
>  		>;
>  };
> +
> +&leds {
> +	compatible = "gpio-leds";
> +	heartbeat {
> +		label = "pandaboard::status1";
> +		gpios = <&gpio4 14 0>;
> +		linux,default-trigger = "heartbeat";
> +	};
> +	mmc {
> +		label = "pandaboard::status2";
> +		gpios = <&gpio1 8 0>;
> +		linux,default-trigger = "gpio";
mmc0?
> +	};
> +};
> +
Other that that,
Tested-by: Nishanth Menon <nm@ti.com>
-- 
Regards,
Nishanth Menon
