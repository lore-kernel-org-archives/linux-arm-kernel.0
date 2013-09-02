From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 02 Sep 2013 15:14:37 +0200
Subject: [PATCH 1/4] ARM: shmobile: r8a7778: add Ether DT support
In-Reply-To: <201309010315.49763.sergei.shtylyov@cogentembedded.com>
References: <201309010311.05466.sergei.shtylyov@cogentembedded.com>
 <201309010315.49763.sergei.shtylyov@cogentembedded.com>
Message-ID: <1643070.uIkONXsrBj@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

Thank you for the patch.

On Sunday 01 September 2013 03:15:48 Sergei Shtylyov wrote:
> Define the generic R8A777x part of the Ether device node.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
>  arch/arm/boot/dts/r8a7778.dtsi |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> Index: renesas/arch/arm/boot/dts/r8a7778.dtsi
> ===================================================================
> --- renesas.orig/arch/arm/boot/dts/r8a7778.dtsi
> +++ renesas/arch/arm/boot/dts/r8a7778.dtsi
> @@ -98,4 +98,15 @@
>  		reg = <0xfffc000 0x118>;
>  		#gpio-range-cells = <3>;
>  	};
> +
> +	ether: ethernet at fde00000 {
> +		device_type = "network";

Documentation/devicetree/bindings/net/sh_eth.txt from "[PATCH 2/2] sh_eth: add 
device tree support" doesn't document this property, should you update it ?

> +		compatible = "renesas,ether-r8a7779";
> +		reg = <0xfde00000 0x400>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 105 0x4>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "disabled";
> +	};
>  };

-- 
Regards,

Laurent Pinchart
