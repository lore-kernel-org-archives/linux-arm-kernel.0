From: robh@kernel.org (Rob Herring)
Date: Thu, 5 Nov 2015 10:36:58 -0600
Subject: [PATCH v2 4/5] ARM: dts: DRA7: add entry for qspi mmap region
In-Reply-To: <1446545174-14193-5-git-send-email-vigneshr@ti.com>
References: <1446545174-14193-1-git-send-email-vigneshr@ti.com>
 <1446545174-14193-5-git-send-email-vigneshr@ti.com>
Message-ID: <20151105163658.GA28885@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 03, 2015 at 03:36:13PM +0530, Vignesh R wrote:
> Add qspi memory mapped region entries for DRA7xx based SoCs. Also,
> update the binding documents for the controller to document this change.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>

You don't really need an example for every possibility, but

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  Documentation/devicetree/bindings/spi/ti_qspi.txt | 13 +++++++++++++
>  arch/arm/boot/dts/dra7.dtsi                       |  6 ++++--
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/ti_qspi.txt b/Documentation/devicetree/bindings/spi/ti_qspi.txt
> index 601a360531a5..f05dd631bef1 100644
> --- a/Documentation/devicetree/bindings/spi/ti_qspi.txt
> +++ b/Documentation/devicetree/bindings/spi/ti_qspi.txt
> @@ -26,3 +26,16 @@ qspi: qspi at 4b300000 {
>  	spi-max-frequency = <25000000>;
>  	ti,hwmods = "qspi";
>  };
> +
> +For dra7xx:
> +qspi: qspi at 4b300000 {
> +	compatible = "ti,dra7xxx-qspi";
> +	reg = <0x4b300000 0x100>, <0x4a002558 0x4>,
> +	      <0x5c000000 0x4000000>;
> +	reg-names = "qspi_base", "qspi_ctrlmod",
> +		    "qspi_mmap";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	spi-max-frequency = <48000000>;
> +	ti,hwmods = "qspi";
> +};
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index e289c706d27d..13c2f10ec217 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -1108,8 +1108,10 @@
>  
>  		qspi: qspi at 4b300000 {
>  			compatible = "ti,dra7xxx-qspi";
> -			reg = <0x4b300000 0x100>;
> -			reg-names = "qspi_base";
> +			reg = <0x4b300000 0x100>, <0x4a002558 0x4>,
> +			      <0x5c000000 0x4000000>;
> +			reg-names = "qspi_base", "qspi_ctrlmod",
> +				    "qspi_mmap";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			ti,hwmods = "qspi";
> -- 
> 2.6.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
