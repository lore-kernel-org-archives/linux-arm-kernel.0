From: b-cousson@ti.com (Benoit Cousson)
Date: Wed, 31 Oct 2012 12:43:38 +0100
Subject: [PATCH v3] ARM: dts: AM33xx: Add SPI node
In-Reply-To: <1351680669-20718-1-git-send-email-avinashphilip@ti.com>
References: <1351680669-20718-1-git-send-email-avinashphilip@ti.com>
Message-ID: <50910EEA.7000904@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/2012 11:51 AM, Philip, Avinash wrote:
> Add McSPI data node to AM33XX device tree file. The McSPI module (and so
> as the driver) is reused from OMAP4.
> 
> Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
> Tested-by: Matt Porter <mporter@ti.com>
> ---

Applied in for_3.8/dts

Thanks,
Benoit

> Changes since v2:
>         - Commit message corrected.
> 	- Rebase on top of for_3.8/dts
> 
> Changes since v1:
>         - Corrected reg offset in reg DT entry.
> 
> :100644 100644 97a7bd3... 6e04789... M	arch/arm/boot/dts/am33xx.dtsi
>  arch/arm/boot/dts/am33xx.dtsi |   24 ++++++++++++++++++++++++
>  1 files changed, 24 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 97a7bd3..6e04789 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -299,5 +299,29 @@
>  				      76>;
>  			ti,hwmods = "rtc";
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
