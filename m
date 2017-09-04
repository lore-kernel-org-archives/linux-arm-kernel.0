From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 4 Sep 2017 10:02:55 +0200
Subject: [PATCH v2 1/2] ARM: dts: sun8i: h3: Enable AP6212 WiFi on mmc1
 on Nanopi M1 Plus
In-Reply-To: <1504283401-4263-2-git-send-email-embed3d@gmail.com>
References: <1504283401-4263-1-git-send-email-embed3d@gmail.com>
 <1504283401-4263-2-git-send-email-embed3d@gmail.com>
Message-ID: <20170904080255.3aywcccu4io2fvxi@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Fri, Sep 01, 2017 at 06:30:00PM +0200, Philipp Rossak wrote:
> From: Philipp Rossak <embed3d@gmail.com>
> 
> The WiFi side of the AP6212 WiFi/BT combo module is connected to
> mmc1. There are also GPIOs for enable and interrupts.
> 
> Enable WiFi on this board by enabling mmc1 and adding the power
> sequencing clocks and GPIO, as well as the chip's interrupt line.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
> index 6256f55..7d18c35 100644
> --- a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
> @@ -48,6 +48,13 @@
>  
>  	aliases {
>  		serial1 = &uart3;
> +		ethernet1 = &sdio_wifi;
> +	};
> +
> +	wifi_pwrseq: wifi_pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		pinctrl-names = "default";
> +		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
>  	};
>  };
>  
> @@ -65,6 +72,24 @@
>  	status = "okay";
>  };
>  
> +&mmc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc1_pins_a>;
> +	vmmc-supply = <&reg_vcc3v3>;

I know I told you you weren't needing vqmmc, but Chen-Yu later told me
that I was wrong about this.

I've added vqmmc back, and applied your patch.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170904/799b5641/attachment.sig>
