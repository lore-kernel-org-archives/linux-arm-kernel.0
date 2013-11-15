From: b.brezillon@overkiz.com (boris brezillon)
Date: Fri, 15 Nov 2013 17:03:46 +0100
Subject: [PATCH 01/11] ARM: at91: dt: at91rm9200ek: add emac and nor flash
 support
In-Reply-To: <1384527006-9040-1-git-send-email-plagnioj@jcrosoft.com>
References: <20131115143855.GR28304@ns203013.ovh.net>
 <1384527006-9040-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <528645E2.3060105@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jean-Christophe,

On 15/11/2013 15:49, Jean-Christophe PLAGNIOL-VILLARD wrote:
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>   arch/arm/boot/dts/at91rm9200ek.dts | 34 ++++++++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
>
> diff --git a/arch/arm/boot/dts/at91rm9200ek.dts b/arch/arm/boot/dts/at91rm9200ek.dts
> index d2d72c3..3ad79b0 100644
> --- a/arch/arm/boot/dts/at91rm9200ek.dts
> +++ b/arch/arm/boot/dts/at91rm9200ek.dts
> @@ -63,12 +63,46 @@
>   					reg = <0>;
>   				};
>   			};
> +
> +			macb0: ethernet at fffbc000 {
> +				phy-mode = "rmii";
> +				status = "okay";
> +			};

This one is already defined abone usb gadget node (see 
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/arch/arm/boot/dts/at91rm9200ek.dts?id=refs/tags/next-20131115).

Best Regards,

Boris

>   		};
>
>   		usb0: ohci at 00300000 {
>   			num-ports = <2>;
>   			status = "okay";
>   		};
> +
> +		nor_flash at 10000000 {
> +			compatible = "cfi-flash";
> +			reg = <0x10000000 0x800000>;
> +			linux,mtd-name = "physmap-flash.0";
> +			bank-width = <2>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			barebox at 0 {
> +				label = "barebox";
> +				reg = <0x00000 0x40000>;
> +			};
> +
> +			bareboxenv at 40000 {
> +				label = "bareboxenv";
> +				reg = <0x40000 0x10000>;
> +			};
> +
> +			kernel at 50000 {
> +				label = "kernel";
> +				reg = <0x50000 0x300000>;
> +			};
> +
> +			root at 350000  {
> +				label = "root";
> +				reg = <0x350000 0x4B0000>;
> +			};
> +		};
>   	};
>
>   	leds {
>
