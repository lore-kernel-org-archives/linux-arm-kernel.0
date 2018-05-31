From: robh@kernel.org (Rob Herring)
Date: Wed, 30 May 2018 22:10:08 -0500
Subject: [PATCH v4 3/5] Documentation: DT: add i.MX EPIT timer binding
In-Reply-To: <20180530120327.27681-4-peron.clem@gmail.com>
References: <20180530120327.27681-1-peron.clem@gmail.com>
 <20180530120327.27681-4-peron.clem@gmail.com>
Message-ID: <20180531031008.GA30302@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2018 at 02:03:25PM +0200, Cl?ment P?ron wrote:
> From: Cl?ment Peron <clement.peron@devialet.com>

"dt-bindings: timer: ..." is the preferred subject prefix.

> 
> Add devicetree binding document for NXP's i.MX SoC specific
> EPIT timer driver.
> 
> Signed-off-by: Cl?ment Peron <clement.peron@devialet.com>
> ---
>  .../devicetree/bindings/timer/fsl,imxepit.txt | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/fsl,imxepit.txt
> 
> diff --git a/Documentation/devicetree/bindings/timer/fsl,imxepit.txt b/Documentation/devicetree/bindings/timer/fsl,imxepit.txt
> new file mode 100644
> index 000000000000..90112d58af10
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/fsl,imxepit.txt
> @@ -0,0 +1,24 @@
> +Binding for the i.MX EPIT timer
> +
> +This binding uses the common clock binding[1].
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt

No need to state this. Listing "clocks" tells us that.

> +
> +Required properties:
> +- compatible: should be "fsl,imx31-epit"

What about imx6q listed below?

> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +- interrupts: Should contain EPIT controller interrupt
> +- clocks: list of clock specifiers, must contain an entry for each required
> +  entry in clock-names
> +- clock-names : should include entries "ipg", "per"
> +
> +Example for i.MX6QDL:
> +	epit1: epit at 20d0000 {

timer at ...

> +		compatible = "fsl,imx6q-epit", "fsl,imx31-epit";
> +		reg = <0x020d0000 0x4000>;
> +		interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&clks IMX6QDL_CLK_IPG_PER>,
> +			<&clks IMX6QDL_CLK_EPIT1>;
> +		clock-names = "ipg", "per";
> +	};
> -- 
> 2.17.0
> 
