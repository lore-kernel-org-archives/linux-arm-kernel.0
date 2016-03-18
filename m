From: robh@kernel.org (Rob Herring)
Date: Fri, 18 Mar 2016 11:10:57 -0500
Subject: [PATCH 17/18] Documentation: dt: add Vybrid DDR memory
 controller bindings
In-Reply-To: <1457576219-7971-18-git-send-email-stefan@agner.ch>
References: <1457576219-7971-1-git-send-email-stefan@agner.ch>
 <1457576219-7971-18-git-send-email-stefan@agner.ch>
Message-ID: <20160318161057.GA31181@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 09, 2016 at 06:16:58PM -0800, Stefan Agner wrote:
> Add device-tree bindings of Vybrids LPDDR2/DDR3 SDRAM Memory
> Controller. Access to the device is required to put the memory
> into self-refresh mode.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  .../bindings/arm/freescale/fsl,vf610-ddrmc.txt     | 23 ++++++++++++++++++++++

Move to bindings/memory-controllers/

>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,vf610-ddrmc.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-ddrmc.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-ddrmc.txt
> new file mode 100644
> index 0000000..56a71d6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-ddrmc.txt
> @@ -0,0 +1,23 @@
> +Freescale Vybrid LPDDR2/DDR3 SDRAM Memory Controller
> +
> +The memory controller supports high performance applications for 16-bit or
> +8-bit DDR2, or LPDDR SDRAM memories.
> +
> +Required properties:
> +- compatible:	"fsl,vf610-ddrmc"
> +- reg:		the register range of the DDRMC registers
> +- clocks:	DDRMC main clock to clock memory and access registers.
> +- clock-names:	Must contain "ddrc", matching entry in the clocks property.
> +- fsl,has-cke-reset-pulls:
> +		States whether pull-down/up are populated on DDR CKE/RESET
> +		signals to allow using DDR self-refresh modes (see Vybrid
> +		Hardware Development Guide for details).
> +
> +Example:
> +	ddrmc: ddrmc at 400ae000 {

memory-controller at ...

> +		compatible = "fsl,vf610-ddrmc";
> +		reg = <0x400ae000 0x1000>;
> +		clocks = <&clks VF610_CLK_DDRMC>;
> +		clock-names = "ddrc";
> +		fsl,has-cke-reset-pulls;
> +	}
> -- 
> 2.7.2
> 
