From: horms@verge.net.au (Simon Horman)
Date: Thu, 21 Nov 2013 13:56:02 +0900
Subject: [PATCH] ARM: shmobile: Use r8a7790 suffix for MMCIF compat string
In-Reply-To: <20131120000553.27024.20445.sendpatchset@w520>
References: <20131120000553.27024.20445.sendpatchset@w520>
Message-ID: <20131121045600.GU31130@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 20, 2013 at 09:05:53AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add "renesas,mmcif-r8a7790" to the compatible string for MMCIF
> in case of r8a7790. This makes the MMCIF follow the same style
> as the other devices and also makes it more future proof.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/arm/boot/dts/r8a7790.dtsi |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, I will queue this up.
Assuming all goes will I plan to push this and other updates
today or tomorrow.

> 
> --- 0001/arch/arm/boot/dts/r8a7790.dtsi
> +++ work/arch/arm/boot/dts/r8a7790.dtsi	2013-11-20 08:18:51.000000000 +0900
> @@ -223,7 +223,7 @@
>  	};
>  
>  	mmcif0: mmcif at ee200000 {
> -		compatible = "renesas,sh-mmcif";
> +		compatible = "renesas,mmcif-r8a7790", "renesas,sh-mmcif";
>  		reg = <0 0xee200000 0 0x80>;
>  		interrupt-parent = <&gic>;
>  		interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;
> @@ -232,7 +232,7 @@
>  	};
>  
>  	mmcif1: mmc at ee220000 {
> -		compatible = "renesas,sh-mmcif";
> +		compatible = "renesas,mmcif-r8a7790", "renesas,sh-mmcif";
>  		reg = <0 0xee220000 0 0x80>;
>  		interrupt-parent = <&gic>;
>  		interrupts = <0 170 IRQ_TYPE_LEVEL_HIGH>;
> 
