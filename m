From: b-cousson@ti.com (Benoit Cousson)
Date: Fri, 19 Oct 2012 10:24:15 +0200
Subject: [PATCH v2] arm/dts: AM33XX: Add SPI device tree data
In-Reply-To: <1347946228-25874-1-git-send-email-avinashphilip@ti.com>
References: <1347946228-25874-1-git-send-email-avinashphilip@ti.com>
Message-ID: <50810E2F.5@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Avinash,

This look good to me except the: status = "disabled".

The "disabled" should be reserved for variant that does not contain the IP.
Is it the case here?

Regards,
Benoit

On 09/18/2012 07:30 AM, Philip, Avinash wrote:
> Add McSPI data node to AM33XX device tree file. The McSPI module (and so
> as the driver) is reused from OMAP4.
> 
> Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
> Tested-by: Matt Porter <mporter@ti.com>
> ---
> Changes since v1:
>         - Corrected reg offset in reg DT entry.
> 
> :100644 100644 ff3badb... 065fd54... M	arch/arm/boot/dts/am33xx.dtsi
>  arch/arm/boot/dts/am33xx.dtsi |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index ff3badb..065fd54 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -219,5 +219,30 @@
>  			interrupt-parent = <&intc>;
>  			interrupts = <91>;
>  		};
> +
> +		spi0: spi at 48030000 {
> +			compatible = "ti,omap4-mcspi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x48030000 0x400>;
> +			interrupt-parent = <&intc>;
> +			interrupt = <65>;
> +			ti,spi-num-cs = <2>;
> +			ti,hwmods = "spi0";
> +			status = "disabled";
> +
> +		};
> +
> +		spi1: spi at 481a0000 {
> +			compatible = "ti,omap4-mcspi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x481a0000 0x400>;
> +			interrupt-parent = <&intc>;
> +			interrupt = <125>;
> +			ti,spi-num-cs = <2>;
> +			ti,hwmods = "spi1";
> +			status = "disabled";
> +		};
>  	};
>  };
> 
