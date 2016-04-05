From: andy.gross@linaro.org (Andy Gross)
Date: Tue, 5 Apr 2016 00:59:06 -0500
Subject: [PATCH 1/2] qcom: ipq4019: Add regulator support to DK04 device
 tree
In-Reply-To: <1459804090-31739-1-git-send-email-ssambang@codeaurora.org>
References: <1459804090-31739-1-git-send-email-ssambang@codeaurora.org>
Message-ID: <20160405055906.GB2639@hector>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2016 at 02:08:10PM -0700, Sreedhar Sambangi wrote:
>     This adds the regulator nodes to DK04 device tree to support
> 
> Change-Id: I9c1df0e720a330bf6db1889fd2247f6a70ea6faa
> Signed-off-by: Sreedhar Sambangi <ssambang@codeaurora.org>
> ---
>  .../bindings/regulator/ipq4019-regulator.txt          | 19 +++++++++++++++++++
>  arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi         | 11 +++++++++++
>  2 files changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/ipq4019-regulator.txt
> 
> diff --git a/Documentation/devicetree/bindings/regulator/ipq4019-regulator.txt b/Documentation/devicetree/bindings/regulator/ipq4019-regulator.txt
> new file mode 100644
> index 0000000..9d934a4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/ipq4019-regulator.txt
> @@ -0,0 +1,19 @@
> +* Qualcomm Technologies, Inc. IPQ4019 regulators
> +
> +Required properties:
> +- compatible		: Must be "regulator-ipq4019".
> +- states		: Selection of available voltages and corresponding values
> +- reg			: Register address for controlling LDO
> +- mask			: Mask value for switching voltages
> +Example:

How many LDOs are there on the IPQ4019?  Can you document all of the supplies?
You can figure this out by looking for the vdd pins in the chip documentation

> +
> +	vccq_sd0: regulator at 0 {
> +		compatible = "qcom,regulator-ipq4019";
> +		regulator-name = "SD0 VccQ";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3000000>;
> +		states = <3000000 0x3
> +			1800000 0x1>;

So there are only 2 states?  No linear range from 1.8 to 3.3?

> +		reg = <0x01948000 0x4>;
> +		mask = <0x3>;
> +	};
