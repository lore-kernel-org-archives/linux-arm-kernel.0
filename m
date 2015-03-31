From: horms@verge.net.au (Simon Horman)
Date: Tue, 31 Mar 2015 09:21:13 +0900
Subject: [PATCH 2/2] ARM: shmobile: r8a7790: add EtherAVB DT support
In-Reply-To: <8163383.0UU0Q5gsLE@wasted.cogentembedded.com>
References: <1625400.M0MxPQybIy@wasted.cogentembedded.com>
 <8163383.0UU0Q5gsLE@wasted.cogentembedded.com>
Message-ID: <20150331002113.GB16289@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 31, 2015 at 12:59:41AM +0300, Sergei Shtylyov wrote:
> Define the generic R8A7790 part of the EtherAVB device node. 

Please repost once this binding (and associated driver) has been accepted.

> Based on original patch by Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
>  arch/arm/boot/dts/r8a7790.dtsi |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> Index: renesas/arch/arm/boot/dts/r8a7790.dtsi
> ===================================================================
> --- renesas.orig/arch/arm/boot/dts/r8a7790.dtsi
> +++ renesas/arch/arm/boot/dts/r8a7790.dtsi
> @@ -626,6 +626,16 @@
>  		status = "disabled";
>  	};
>  
> +	avb: ethernet at e6800000 {
> +		compatible = "renesas,ravb-r8a7790";
> +		reg = <0 0xe6800000 0 0x800>, <0 0xee0e8000 0 0x4000>;
> +		interrupts = <0 163 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp8_clks R8A7790_CLK_ETHERAVB>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "disabled";
> +	};
> +
>  	sata0: sata at ee300000 {
>  		compatible = "renesas,sata-r8a7790";
>  		reg = <0 0xee300000 0 0x2000>;
> 
