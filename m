From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 20 Jan 2015 21:02:16 +0100
Subject: [PATCH v4 3/5] ARM: sunxi: dts: Add PS2 nodes to dtsi for A10
 and A20
In-Reply-To: <1421417021-3247-4-git-send-email-vishnupatekar0510@gmail.com>
References: <1421417021-3247-1-git-send-email-vishnupatekar0510@gmail.com>
 <1421417021-3247-4-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <20150120200216.GV4367@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vishnu,

On Fri, Jan 16, 2015 at 07:33:39PM +0530, Vishnu Patekar wrote:
> Signed-off-by: VishnuPatekar <vishnupatekar0510@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Why is there Hans Signed-off here?

> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi |   16 ++++++++++++++++
>  arch/arm/boot/dts/sun7i-a20.dtsi |   16 ++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index 7b4099f..2c31242 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -795,5 +795,21 @@
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  		};
> +
> +		ps20: ps2 at 01c2a000 {
> +			compatible = "allwinner,sun4i-a10-ps2";
> +			reg = <0x01c2a000 0x400>;
> +			interrupts = <62>;
> +			clocks = <&apb1_gates 6>;
> +			status = "disabled";
> +		};
> +
> +		ps21: ps2 at 01c2a400 {
> +			compatible = "allwinner,sun4i-a10-ps2";
> +			reg = <0x01c2a400 0x400>;
> +			interrupts = <63>;
> +			clocks = <&apb1_gates 7>;
> +			status = "disabled";
> +		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index e21ce59..f35c691 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -1093,5 +1093,21 @@
>  			#interrupt-cells = <3>;
>  			interrupts = <1 9 0xf04>;
>  		};
> +
> +		ps20: ps2 at 01c2a000 {
> +			compatible = "allwinner,sun4i-a10-ps2";
> +			reg = <0x01c2a000 0x400>;
> +			interrupts = <0 62 4>;
> +			clocks = <&apb1_gates 6>;
> +			status = "disabled";
> +		};
> +
> +		ps21: ps2 at 01c2a400 {
> +			compatible = "allwinner,sun4i-a10-ps2";
> +			reg = <0x01c2a400 0x400>;
> +			interrupts = <0 63 4>;

We recently switched to using includes and defines for these hardcoded
values.

Could you switch to it as well?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150120/edd97837/attachment.sig>
