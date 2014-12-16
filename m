From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 16 Dec 2014 10:32:41 +0100
Subject: [PATCHv3 3/5] ARM: sunxi: dts: Add PS2 nodes to dtsi for A10 and
 A20
In-Reply-To: <1418408748-9797-4-git-send-email-vishnupatekar0510@gmail.com>
References: <1418408748-9797-1-git-send-email-vishnupatekar0510@gmail.com>
 <1418408748-9797-4-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <20141216093241.GN4337@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vishnu,

On Fri, Dec 12, 2014 at 11:55:46PM +0530, VishnuPatekar wrote:
> 1) Fixup the sun4i ps/2 nodes interrupt property, sun4i interrupts take
> only 1 specifier
> 
> 2) dt bindings should use the compat string for the earliest version of the
> hardware which has the relevant hardware block, unless there are differences,
> the A10 and A20 ps2 controllers are identical, so for both sun4i-a10-ps2
> should be used as compat string, update the sun7i.dtsi ps2 entries to
> use the sun4i-a10-ps2 compat string.

This shouldn't be a changelog, but what this patch actually does.

> Signed-off-by: VishnuPatekar <vishnupatekar0510@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi |   17 +++++++++++++++++
>  arch/arm/boot/dts/sun7i-a20.dtsi |   18 ++++++++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index 7b4099f..ef9a01c 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -629,6 +629,7 @@
>  				allwinner,drive = <0>;
>  				allwinner,pull = <0>;
>  			};
> +

This is an uneeded change

>  		};
>  
>  		timer at 01c20c00 {
> @@ -795,5 +796,21 @@
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
> index e21ce59..6ab7714 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -866,6 +866,7 @@
>  				    allwinner,drive = <0>;
>  				    allwinner,pull = <0>;
>  			};
> +

Ditto.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141216/71c6a958/attachment.sig>
