From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 20 Jan 2015 21:03:07 +0100
Subject: [PATCH v4 4/5] ARM: sunxi: dts: Add A10/A20 PS2 pin muxing options
In-Reply-To: <1421417021-3247-5-git-send-email-vishnupatekar0510@gmail.com>
References: <1421417021-3247-1-git-send-email-vishnupatekar0510@gmail.com>
 <1421417021-3247-5-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <20150120200307.GW4367@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 07:33:40PM +0530, Vishnu Patekar wrote:
> Signed-off-by: VishnuPatekar <vishnupatekar0510@gmail.com>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi |   14 ++++++++++++++
>  arch/arm/boot/dts/sun7i-a20.dtsi |   14 ++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index 2c31242..8fade3e 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -629,6 +629,20 @@
>  				allwinner,drive = <0>;
>  				allwinner,pull = <0>;
>  			};
> +
> +			ps20_pins_a: ps20 at 0 {
> +				allwinner,pins = "PI20", "PI21";
> +				allwinner,function = "ps2";
> +				allwinner,drive = <0>;
> +				allwinner,pull = <0>;
> +			};
> +
> +			ps21_pins_a: ps21 at 0 {
> +				allwinner,pins = "PH12", "PH13";
> +				allwinner,function = "ps2";
> +				allwinner,drive = <0>;
> +				allwinner,pull = <0>;
> +			};
>  		};
>  
>  		timer at 01c20c00 {
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index f35c691..f9dd274 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -866,6 +866,20 @@
>  				    allwinner,drive = <0>;
>  				    allwinner,pull = <0>;
>  			};
> +
> +			ps20_pins_a: ps20 at 0 {
> +				allwinner,pins = "PI20", "PI21";
> +				allwinner,function = "ps2";
> +				allwinner,drive = <0>;
> +				allwinner,pull = <0>;
> +			};
> +
> +			ps21_pins_a: ps21 at 0 {
> +				allwinner,pins = "PH12", "PH13";
> +				allwinner,function = "ps2";
> +				allwinner,drive = <0>;
> +				allwinner,pull = <0>;
> +			};
>  		};

Same thing here, we're using defines now for the values in ,drive and
,pull, please use them.

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150120/78a0807c/attachment.sig>
