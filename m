From: robh@kernel.org (Rob Herring)
Date: Thu, 16 Jun 2016 13:39:53 -0500
Subject: [PATCHv3 4/7] Documentation: dt: socfpga: Add Arria10 Ethernet
 binding
In-Reply-To: <1465852752-11018-5-git-send-email-tthayer@opensource.altera.com>
References: <1465852752-11018-1-git-send-email-tthayer@opensource.altera.com>
 <1465852752-11018-5-git-send-email-tthayer@opensource.altera.com>
Message-ID: <20160616183953.GA6667@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2016 at 04:19:09PM -0500, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> Add the device tree bindings needed to support the Altera Ethernet
> FIFO buffers on the Arria10 chip.
> 
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> ---
> v2  No Change
> v3  Change to common compatible string based on maintainer comments
>     Add local IRQ values.
> ---
>  .../bindings/arm/altera/socfpga-eccmgr.txt         |   24 ++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
> index 15eb0df..e9febbb 100644
> --- a/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
> +++ b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
> @@ -82,6 +82,14 @@ Required Properties:
>  - interrupts : Should be single bit error interrupt, then double bit error
>  	interrupt, in this order.
>  
> +Ethernet FIFO ECC
> +Required Properties:
> +- compatible : Should be "altr,socfpga-eth-mac-ecc"
> +- reg        : Address and size for ECC block registers.
> +- parent     : phandle to parent Ethernet node.

parent is too vague. How about altr,ethernet-mac.

> +- interrupts : Should be single bit error interrupt, then double bit error
> +	interrupt, in this order.
> +
>  Example:
>  
>  	eccmgr: eccmgr at ffd06000 {
> @@ -108,4 +116,20 @@ Example:
>  			interrupts = <1 IRQ_TYPE_LEVEL_HIGH>,
>  				     <33 IRQ_TYPE_LEVEL_HIGH> ;
>  		};
> +
> +		emac0-rx-ecc at ff8c0800 {
> +			compatible = "altr,socfpga-eth-mac-ecc";
> +			reg = <0xff8c0800 0x400>;
> +			parent = <&gmac0>;
> +			interrupts = <4 IRQ_TYPE_LEVEL_HIGH>,
> +				     <36 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		emac0-tx-ecc at ff8c0c00 {
> +			compatible = "altr,socfpga-eth-mac-ecc";
> +			reg = <0xff8c0c00 0x400>;
> +			parent = <&gmac0>;
> +			interrupts = <5 IRQ_TYPE_LEVEL_HIGH>,
> +				     <37 IRQ_TYPE_LEVEL_HIGH>;
> +		};
>  	};
> -- 
> 1.7.9.5
> 
