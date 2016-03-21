From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 21 Mar 2016 19:21:25 +0100
Subject: [linux-sunxi][PATCH v2 4/5] ARM: dts: sun4i: Add SPDIF to the
 Mele A1000
In-Reply-To: <1458576642-4078-5-git-send-email-codekipper@gmail.com>
References: <1458576642-4078-1-git-send-email-codekipper@gmail.com>
 <1458576642-4078-5-git-send-email-codekipper@gmail.com>
Message-ID: <20160321182125.GH30977@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 21, 2016 at 05:10:41PM +0100, codekipper at gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
> 
> Enable the S/PDIF transmitter that is present on the A1000.
> 
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  arch/arm/boot/dts/sun4i-a10-a1000.dts | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> index 97570cb..aaf5605 100644
> --- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> @@ -87,6 +87,23 @@
>  		enable-active-high;
>  		gpio = <&pio 7 15 GPIO_ACTIVE_HIGH>;
>  	};
> +
> +	sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "On-board SPDIF";

Please add a newline here.


> +		simple-audio-card,cpu {
> +			sound-dai = <&spdif>;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&spdif_out>;
> +		};
> +	};
> +
> +	spdif_out: spdif-out {
> +		#sound-dai-cells = <0>;
> +		compatible = "linux,spdif-dit";
> +	};
>  };
>  
>  &ahci {
> @@ -188,6 +205,12 @@
>  	status = "okay";
>  };
>  
> +&spdif {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spdif_tx_pins_a>;
> +	status = "okay";
> +};
> +
>  &uart0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart0_pins_a>;
> -- 
> 2.7.4
> 

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160321/b3e213c5/attachment.sig>
