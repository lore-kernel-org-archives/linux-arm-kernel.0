From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 21 Mar 2016 19:20:45 +0100
Subject: [linux-sunxi][PATCH v2 2/5] ARM: dts :sunxi: Add SPDIF pins to
 A10 and A20
In-Reply-To: <1458576642-4078-3-git-send-email-codekipper@gmail.com>
References: <1458576642-4078-1-git-send-email-codekipper@gmail.com>
 <1458576642-4078-3-git-send-email-codekipper@gmail.com>
Message-ID: <20160321182045.GG30977@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 21, 2016 at 05:10:39PM +0100, codekipper at gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
> 
> Add the SPDIF pins to the A10 and A20 dtsi.
> 
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi | 21 +++++++++++++++++++++
>  arch/arm/boot/dts/sun7i-a20.dtsi | 21 +++++++++++++++++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index 2c8f5e6..0483640 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -1006,6 +1006,27 @@
>  				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>  				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>  			};
> +
> +			spdif_tx_pins_a: spdif at 0 {
> +				allwinner,pins = "PB13";
> +				allwinner,function = "spdif";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
> +			};
> +
> +			spdif_rx_pins_a: spdif at 1 {
> +				allwinner,pins = "PB12";
> +				allwinner,function = "spdif";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};
> +
> +			spdif_mclk_pins_a: spdif at 2 {
> +				allwinner,pins = "PB3";
> +				allwinner,function = "spdif";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};

If you're not going to use these pins, please don't add them yet.

In order to avoid bloating the DT uselessly, we try to not add unused nodes.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160321/c80d97de/attachment.sig>
