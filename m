From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 11 Dec 2015 22:41:19 +0800
Subject: [PATCH v3] ARM: dts: ls1021a: add sata node to dts
In-Reply-To: <1449040591-13618-1-git-send-email-Yuantian.Tang@freescale.com>
References: <1449040591-13618-1-git-send-email-Yuantian.Tang@freescale.com>
Message-ID: <20151211144119.GM11252@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2015 at 03:16:31PM +0800, Yuantian.Tang at freescale.com wrote:
> From: Tang Yuantian <Yuantian.Tang@freescale.com>
> 
> Added sata node to ls1021aqds and ls1021atwr board to support
> sata function.
> 
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> ---
> v3:
> 	- refine the title and commit message
> 	- added a status property so that sata can be controlled
> 	by board specific dts.
> v2:
> 	- put reg-names right after reg property
> 
>  arch/arm/boot/dts/ls1021a-qds.dts |  4 ++++
>  arch/arm/boot/dts/ls1021a-twr.dts |  4 ++++
>  arch/arm/boot/dts/ls1021a.dtsi    | 11 +++++++++++
>  3 files changed, 19 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-qds.dts
> index 0521e68..803cc54 100644
> --- a/arch/arm/boot/dts/ls1021a-qds.dts
> +++ b/arch/arm/boot/dts/ls1021a-qds.dts
> @@ -327,3 +327,7 @@
>  &uart1 {
>  	status = "okay";
>  };
> +
> +&sata {
> +	status = "okay";
> +};

The labelled nodes are sorted alphabetically.  Please keep the new
addition sorted too.

> diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-twr.dts
> index fbb89d1..62dec7c 100644
> --- a/arch/arm/boot/dts/ls1021a-twr.dts
> +++ b/arch/arm/boot/dts/ls1021a-twr.dts
> @@ -219,3 +219,7 @@
>  &uart1 {
>  	status = "okay";
>  };
> +
> +&sata {
> +	status = "okay";
> +};

Ditto

Shawn

> diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> index 9430a99..da9bd7e 100644
> --- a/arch/arm/boot/dts/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -143,6 +143,17 @@
>  			status = "disabled";
>  		};
>  
> +		sata: sata at 3200000 {
> +			compatible = "fsl,ls1021a-ahci";
> +			reg = <0x0 0x3200000 0x0 0x10000>,
> +			      <0x0 0x20220520 0x0 0x4>;
> +			reg-names = "ahci", "sata-ecc";
> +			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&platform_clk 1>;
> +			dma-coherent;
> +			status = "disabled";
> +		};
> +
>  		scfg: scfg at 1570000 {
>  			compatible = "fsl,ls1021a-scfg", "syscon";
>  			reg = <0x0 0x1570000 0x0 0x10000>;
> -- 
> 2.1.0.27.g96db324
> 
> 
