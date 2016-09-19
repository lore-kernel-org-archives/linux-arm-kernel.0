From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 19 Sep 2016 10:18:24 +0200
Subject: [PATCH v4 1/2] ARM: dts: sun8i: add pinmux for UART1 at PG
In-Reply-To: <20160916151642.27907-1-icenowy@aosc.xyz>
References: <20160916151642.27907-1-icenowy@aosc.xyz>
Message-ID: <20160919081824.GB8719@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 16, 2016 at 11:16:41PM +0800, Icenowy Zheng wrote:
> The UART1 at PG (PG6, PG7, PG8, PG9) is, in the Allwinner's reference
> tablet design of A23/33, used to connect to UART Bluetooth cards.
> 
> Add the pinmux for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
> This patch is splited in v4.
> 
>  arch/arm/boot/dts/sun8i-a23-a33.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> index 7e05e09..c340885 100644
> --- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> @@ -361,6 +361,20 @@
>  				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>  			};
>  
> +			uart1_pins_a: uart1 at 0 {
> +				allwinner,pins = "PG6", "PG7";
> +				allwinner,function = "uart1";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};
> +
> +			uart1_pins_cts_rts_a: uart1-cts-rts at 0 {
> +				allwinner,pins = "PG8", "PG9";
> +				allwinner,function = "uart1";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +			};
> +

It turns out the allwinner,drive and allwinner,pull properties are
optionnal. I removed them, and applied that patch.

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
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160919/38cead74/attachment.sig>
