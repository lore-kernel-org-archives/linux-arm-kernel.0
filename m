From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 28 Jun 2018 08:40:18 +0200
Subject: [RFC PATCH 4/5] arm: dts: zynq: rename board zed to zedboard
In-Reply-To: <20180628054205.17737-5-luaraneda@gmail.com>
References: <20180628054205.17737-1-luaraneda@gmail.com>
 <20180628054205.17737-5-luaraneda@gmail.com>
Message-ID: <9d00dae5-835f-43b4-0a78-2aa43bbcff54@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.6.2018 07:42, Luis Araneda wrote:
> The real name of the board is ZedBoard, from Avnet
> 
> Signed-off-by: Luis Araneda <luaraneda@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/xilinx.txt      | 2 +-
>  arch/arm/boot/dts/Makefile                            | 2 +-
>  arch/arm/boot/dts/{zynq-zed.dts => zynq-zedboard.dts} | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>  rename arch/arm/boot/dts/{zynq-zed.dts => zynq-zedboard.dts} (93%)
> 
> diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
> index f1e911058..d10adc4d0 100644
> --- a/Documentation/devicetree/bindings/arm/xilinx.txt
> +++ b/Documentation/devicetree/bindings/arm/xilinx.txt
> @@ -30,7 +30,7 @@ Additional compatible strings:
>    "xlnx,zynq-zc770-xm013"
>  
>  - Avnet ZedBoard board
> -  "avnet,zynq-zed"
> +  "avnet,zynq-zedboard"
>  
>  - Digilent Zybo board
>    "digilent,zynq-zybo"
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 37a3de760..e4c39e26f 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1108,7 +1108,7 @@ dtb-$(CONFIG_ARCH_ZYNQ) += \
>  	zynq-zc770-xm011.dtb \
>  	zynq-zc770-xm012.dtb \
>  	zynq-zc770-xm013.dtb \
> -	zynq-zed.dtb \
> +	zynq-zedboard.dtb \
>  	zynq-zybo.dtb \
>  	zynq-zybo-z7.dtb
>  dtb-$(CONFIG_MACH_ARMADA_370) += \
> diff --git a/arch/arm/boot/dts/zynq-zed.dts b/arch/arm/boot/dts/zynq-zedboard.dts
> similarity index 93%
> rename from arch/arm/boot/dts/zynq-zed.dts
> rename to arch/arm/boot/dts/zynq-zedboard.dts
> index bf3e26dbf..540581c56 100644
> --- a/arch/arm/boot/dts/zynq-zed.dts
> +++ b/arch/arm/boot/dts/zynq-zedboard.dts
> @@ -8,7 +8,7 @@
>  
>  / {
>  	model = "Avnet ZedBoard board";
> -	compatible = "avnet,zynq-zed", "xlnx,zynq-7000";
> +	compatible = "avnet,zynq-zedboard", "xlnx,zynq-7000";
>  
>  	aliases {
>  		ethernet0 = &gem0;
> 

It will just cause confusion and I can't see any benefit to rename this
file. If you want to state different compatible string with full board
name I am fine with that but that's it.

Thanks,
Michal
