From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 09 Feb 2016 09:30:02 +0100
Subject: [PATCH v4 09/10] arm64: dts: Add main Thermal info to rk3368.dtsi
In-Reply-To: <1447044542-30859-10-git-send-email-wxt@rock-chips.com>
References: <1447044542-30859-1-git-send-email-wxt@rock-chips.com>
 <1447044542-30859-10-git-send-email-wxt@rock-chips.com>
Message-ID: <42802946.20XC68fnyM@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,

Am Montag, 9. November 2015, 12:49:01 schrieb Caesar Wang:
> This patch add the thermal needed info on RK3368.
> Meanwhile, support the trips to throttle for thermal.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Acked-by: Eduardo Valentin <edubezval@gmail.com>

[...]

> @@ -829,6 +855,16 @@
>  			};
>  		};
> 
> +		tsadc {
> +			otp_gpio: otp-gpio {
> +				rockchip,pins = <0 10 RK_FUNC_GPIO &pcfg_pull_none>;
> +			};
> +
> +			otp_out: otp-out {
> +				rockchip,pins = <0 10 RK_FUNC_1 &pcfg_pull_none>;
> +			};
> +		};
> +
>  		uart0 {
>  			uart0_xfer: uart0-xfer {
>  				rockchip,pins = <2 24 RK_FUNC_1 &pcfg_pull_up>,

As it came up just now, these pinctrl settings seem strange. I.e. according 
to the TRM gpio0b2 [= gpio0 10] func_1 is sc_rst, which seems to be the 
smartcard controller?

It came up because it seems the Tronsmart R68 board seems to use this pin 
for controlling the vcc_host regulator instead.


Heiko
