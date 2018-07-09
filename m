From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 9 Jul 2018 10:18:36 +0200
Subject: [PATCH v2 2/3] dt-bindings: xilinx: Add missing zynq boards and
 sort entries
In-Reply-To: <20180706060158.24155-3-luaraneda@gmail.com>
References: <20180706060158.24155-1-luaraneda@gmail.com>
 <20180706060158.24155-3-luaraneda@gmail.com>
Message-ID: <1088d908-eaa1-78a8-f1a5-1a7d82eb5afb@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6.7.2018 08:01, Luis Araneda wrote:
> The bindings were missing when adding the device-tree files
> 
> Also, improve description of existing boards, sort them
> alphabetically by manufacturer, and migrate the contents
> of adapteva dt dindigns into Xilinx's
> 
> Signed-off-by: Luis Araneda <luaraneda@gmail.com>
> ---
> 
> Changes since v1 (RFC):
> - Don't remove "internal" word from Xilinx boards on dt-bindings
> - Migrate content of adapteva dt-binding file into Xilinx's
> - Sort additional compatible strings alphabetically
>   by manufacturer
> 
>  .../devicetree/bindings/arm/adapteva.txt      |  7 -----
>  .../devicetree/bindings/arm/xilinx.txt        | 30 +++++++++++++++----
>  2 files changed, 25 insertions(+), 12 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/adapteva.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/adapteva.txt b/Documentation/devicetree/bindings/arm/adapteva.txt
> deleted file mode 100644
> index 1d8af9e36065..000000000000
> --- a/Documentation/devicetree/bindings/arm/adapteva.txt
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -Adapteva Platforms Device Tree Bindings
> ----------------------------------------
> -
> -Parallella board
> -
> -Required root node properties:
> -    - compatible = "adapteva,parallella";
> diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
> index b9043bc35c14..26fe5ecc4332 100644
> --- a/Documentation/devicetree/bindings/arm/xilinx.txt
> +++ b/Documentation/devicetree/bindings/arm/xilinx.txt
> @@ -8,18 +8,38 @@ Required root node properties:
>  
>  Additional compatible strings:
>  
> -- Xilinx internal board cc108
> +- Adapteva Parallella board
> +  "adapteva,parallella"
> +
> +- Avnet MicroZed board
> +  "avnet,zynq-microzed"
> +  "xlnx,zynq-microzed"
> +
> +- Avnet ZedBoard board
> +  "avnet,zynq-zed"
> +  "xlnx,zynq-zed"
> +
> +- Digilent Zybo board
> +  "digilent,zynq-zybo"
> +
> +- Digilent Zybo Z7 board
> +  "digilent,zynq-zybo-z7"
> +
> +- Xilinx CC108 internal board
>    "xlnx,zynq-cc108"
>  
> -- Xilinx internal board zc770 with different FMC cards
> +- Xilinx ZC702 internal board
> +  "xlnx,zynq-zc702"
> +
> +- Xilinx ZC706 internal board
> +  "xlnx,zynq-zc706"
> +
> +- Xilinx ZC770 internal board, with different FMC cards
>    "xlnx,zynq-zc770-xm010"
>    "xlnx,zynq-zc770-xm011"
>    "xlnx,zynq-zc770-xm012"
>    "xlnx,zynq-zc770-xm013"
>  
> -- Digilent Zybo Z7 board
> -  "digilent,zynq-zybo-z7"
> -
>  ---------------------------------------------------------------
>  
>  Xilinx Zynq UltraScale+ MPSoC Platforms Device Tree Bindings
> 

Please do it with more patches. There are 3 changes in one patch.

Thanks,
Michal
