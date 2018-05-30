From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Wed, 30 May 2018 10:27:51 +0300
Subject: [PATCH v3 3/5] Documentation: DT: add i.MX EPIT timer binding
In-Reply-To: <20180529170436.22711-4-peron.clem@gmail.com>
References: <20180529170436.22711-1-peron.clem@gmail.com>
 <20180529170436.22711-4-peron.clem@gmail.com>
Message-ID: <7f2f8b6b-b7f6-99c1-fc5f-a7628a751fdc@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cl?ment,

On 05/29/2018 08:04 PM, Cl?ment P?ron wrote:
> From: Cl?ment Peron <clement.peron@devialet.com>
> 
> Add devicetree binding document for NXP's i.MX SoC specific
> EPIT timer driver.
> 
> Signed-off-by: Cl?ment Peron <clement.peron@devialet.com>
> ---
>  .../devicetree/bindings/clock/imx6q,epit.txt  | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/imx6q,epit.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/imx6q,epit.txt b/Documentation/devicetree/bindings/clock/imx6q,epit.txt
> new file mode 100644
> index 000000000000..a84a60c6ae35
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/imx6q,epit.txt

The file should be renamed to a more generic name like 'imx,epit.txt'
or 'imx31,epit.txt'.

Also note that the folder is incorrectly selected, it must be
Documentation/devicetree/bindings/timer/

> @@ -0,0 +1,24 @@
> +Binding for the i.MX6 EPIT timer

Let's change it to 'Binding for the i.MX EPIT timer'.

> +
> +This binding uses the common clock binding[1].
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Required properties:
> +- compatible: should be "fsl,imx6q-epit"

Compatible should be "fsl,imx31-epit", i.MX31 SoC seems to be the first
one in the series, which has the timer module.

There should be added more compatibles specific to later SoC versions.

> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +- interrupts: Should contain EPIT controller interrupt
> +- clocks: list of clock specifiers, must contain an entry for each required
> +  entry in clock-names
> +- clock-names : should include entries "ipg", "per"
> +
> +Example:
> +	epit1: epit at 20d0000 {
> +		compatible = "fsl,imx6q-epit";

For i.MX6Q example a list of compatibles should be updated like

	compatible = "fsl,imx6q-epit", "fsl,imx31-epit";

> +		reg = <0x020d0000 0x4000>;
> +		interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&clks IMX6QDL_CLK_EPIT1>,
> +			<&clks IMX6QDL_CLK_IPG_PER>;
> +		clock-names = "ipg", "per";

It looks like "ipg" and "per" clocks are swapped, please double check it.

> +	};
> 

--
With best wishes,
Vladimir
