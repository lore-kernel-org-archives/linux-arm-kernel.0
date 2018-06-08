From: horms@verge.net.au (Simon Horman)
Date: Fri, 8 Jun 2018 15:54:56 +0200
Subject: [PATCH v2 2/5] arm64: dts: renesas: r8a77980: add VSPD support
In-Reply-To: <5f151ec5-bec7-ed06-cb94-4f0cfe8e43dc@cogentembedded.com>
References: <390fabf0-4caf-1600-3780-1893207d94f7@cogentembedded.com>
 <5f151ec5-bec7-ed06-cb94-4f0cfe8e43dc@cogentembedded.com>
Message-ID: <20180608135456.cathgcuyp24csbwx@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[CC Laurent, Geert]

On Thu, Jun 07, 2018 at 11:20:47PM +0300, Sergei Shtylyov wrote:
> Describe VSPD0 in the R8A77980 device tree; it will be used by DU in
> the next patch...
> 
> Based on the original (and large) patch by Vladimir Barinov.
> 
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
>  arch/arm64/boot/dts/renesas/r8a77980.dtsi |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> Index: renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> ===================================================================
> --- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> +++ renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> @@ -653,6 +653,16 @@
>  			resets = <&cpg 408>;
>  		};
>  
> +		vspd0: vsp at fea20000 {
> +			compatible = "renesas,vsp2";
> +			reg = <0 0xfea20000 0 0x4000>;

As per "[PATCH] arm64: dts: renesas: Fix VSPD registers range"
I think the width of the range should be 0x5000.

> +			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 623>;
> +			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
> +			resets = <&cpg 623>;
> +			renesas,fcp = <&fcpvd0>;
> +		};
> +
>  		fcpvd0: fcp at fea27000 {
>  			compatible = "renesas,fcpv";
>  			reg = <0 0xfea27000 0 0x200>;
> 
