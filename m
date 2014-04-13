From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 13 Apr 2014 17:26:05 +0200
Subject: [PATCH 20/29] ARM: orion5x: convert edmini_v2 to DT pinctrl
In-Reply-To: <1397400006-4315-21-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-21-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140413152605.GB10033@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 13, 2014 at 04:39:57PM +0200, Thomas Petazzoni wrote:
> This commit converts the already partially DT-converted edmini_v2
> platform to use the Device Tree for pinctrl.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  .../dts/orion5x-lacie-ethernet-disk-mini-v2.dts    | 31 ++++++++++++++++++++++
>  arch/arm/mach-orion5x/edmini_v2-setup.c            | 28 -------------------
>  2 files changed, 31 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> index d66d2fa..eee42f7 100644
> --- a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> +++ b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> @@ -29,12 +29,39 @@
>  			 <MBUS_ID(0x09, 0x00) 0 0xf2200000 0x800>;
>  
>  		internal-regs {
> +			pinctrl at 10000 {
> +				pinctrl-0 = <&pmx_rtc &pmx_power_led_ctrl>;
> +				pinctrl-names = "default";
> +
> +				pmx_rtc: pmx-rtc {
> +					marvell,pins = "mpp3";
> +					marvell,function = "gpio";
> +				};
> +
> +				pmx_power_led: pmx-power-led {
> +					marvell,pins = "mpp16";
> +					marvell,function = "gpio";
> +				};
> +
> +				pmx_power_led_ctrl: pmx-power-led-ctrl {
> +					marvell,pins = "mpp17";
> +					marvell,function = "gpio";
> +				};
> +
> +				pmx_power_button: pmx-power-button {
> +					marvell,pins = "mpp18";
> +					marvell,function = "gpio";
> +				};
> +			};

Hi Thomas

One of the things Sebastian did as part of his Kirkwood DT cleanup was
sort pinctrl nodes by label, instead of mpp number. We should probably
discuss this and come to a conclusion before converting Orion5x
platforms.

	Andrew
