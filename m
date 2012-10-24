From: gmbnomis@gmail.com (Simon Baatz)
Date: Wed, 24 Oct 2012 22:40:12 +0200
Subject: [PATCH 7/9] ARM: Kirkwood: Convert ib62x0 to pinctrl.
In-Reply-To: <1351090434-30499-8-git-send-email-andrew@lunn.ch>
References: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
 <1351090434-30499-8-git-send-email-andrew@lunn.ch>
Message-ID: <20121024204011.GA20095@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

first of all thanks for providing these patches!
Just a typo for now:

On Wed, Oct 24, 2012 at 04:53:52PM +0200, Andrew Lunn wrote:
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/boot/dts/kirkwood-ib62x0.dts |   41 +++++++++++++++++++++++++++++++++
>  arch/arm/mach-kirkwood/board-ib62x0.c |   21 -----------------
>  2 files changed, 41 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/kirkwood-ib62x0.dts b/arch/arm/boot/dts/kirkwood-ib62x0.dts
> index 66794ed..713b39b 100644
> --- a/arch/arm/boot/dts/kirkwood-ib62x0.dts
> +++ b/arch/arm/boot/dts/kirkwood-ib62x0.dts
> @@ -16,6 +16,47 @@
>  	};
>  
>  	ocp at f1000000 {
> +		pinctrl: pinctrl at 10000 {
> +			compatible = "marvell,88f6281-pinctrl";
> +			reg = <0x10000 0x20>;
> +
> +			pinctrl-0 = < &pmx_nand
> +				      &pmx_led_os_red &pmx_power_off
> +				      &pmx_led_os_green &pmx_led_usb_transfer
> +				      &pmx_button_reset &pmx_button_usb_copy >;
> +			pinctrl-names = "default";
> +
> +			pmx_nand: pmx-nand {
> +				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3",
> +					       "mpp04", "mpp5", "mpp18",

mpp04 -> mpp4


- Simon
