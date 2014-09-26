From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 26 Sep 2014 14:18:52 +0800
Subject: [PATCHv4 4/6] dt-bindings: arm: add Freescale LS1021A SoC device
 tree binding
In-Reply-To: <1411371952-5618-5-git-send-email-jingchang.lu@freescale.com>
References: <1411371952-5618-1-git-send-email-jingchang.lu@freescale.com>
 <1411371952-5618-5-git-send-email-jingchang.lu@freescale.com>
Message-ID: <20140926061851.GE31948@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 22, 2014 at 03:45:50PM +0800, Jingchang Lu wrote:
> Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.txt | 38 +++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
> index e935d7d..2e0ba09 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.txt
> +++ b/Documentation/devicetree/bindings/arm/fsl.txt
> @@ -74,3 +74,41 @@ Required root node properties:
>  i.MX6q generic board
>  Required root node properties:
>      - compatible = "fsl,imx6q";
> +
> +
> +Freescale LS1021A Platform Device Tree Bindings
> +------------------------------------------------
> +
> +Required root node compatible properties:
> +  - compatible = "fsl,ls1021a";
> +
> +Freescale LS1021A SoC-specific Device Tree Bindings
> +-------------------------------------------
> +
> +Freescale SCFG
> +  scfg is the supplemental configuration unit, that provides SoC specific

s/scfg/SCFG

> +configuration and status registers for the chip. Such as getting PEX port
> +status.
> +  Required properties:
> +  - compatible: should be "fsl,ls1021a-scfg"
> +  - reg: should contain base address and length of SCFG memory-mapped registers
> +
> +Example:
> +	scfg: scfg at 1570000 {
> +		compatible = "fsl,ls1021a-scfg";
> +		reg = <0x0 0x1570000 0x0 0x10000>;
> +	};
> +
> +Freescale DCFG
> +  dcfg is the device configuration unit, that provides general purpose

s/dcfg/DCFG

Shawn

> +configuration and status for the device. Such as setting the secondary
> +core start address and release the secondary core from holdoff and startup.
> +  Required properties:
> +  - compatible: should be "fsl,ls1021a-dcfg"
> +  - reg : should contain base address and length of DCFG memory-mapped registers
> +
> +Example:
> +	dcfg: dcfg at 1ee0000 {
> +		compatible = "fsl,ls1021a-dcfg";
> +		reg = <0x0 0x1ee0000 0x0 0x10000>;
> +	};
> -- 
> 1.8.0
> 
