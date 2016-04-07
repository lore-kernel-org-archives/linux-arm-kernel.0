From: robh@kernel.org (Rob Herring)
Date: Thu, 7 Apr 2016 12:57:36 -0500
Subject: [PATCH 1/2] qcom: ipq4019: Add regulator support to DK04 device
 tree
In-Reply-To: <1459804090-31739-1-git-send-email-ssambang@codeaurora.org>
References: <1459804090-31739-1-git-send-email-ssambang@codeaurora.org>
Message-ID: <20160407175736.GI32257@rob-hp-laptop>
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

Doesn't match your example which correctly has vendor prefix. Also, the 
preferred form is <vendor>,<soc>-<block>.

> +- states		: Selection of available voltages and corresponding values

Too generic of a name.

Is this not fixed by the h/w block?

> +- reg			: Register address for controlling LDO
> +- mask			: Mask value for switching voltages

What else is in this register? If something unrelated, then this is all 
wrong to the regulator. You can only define the register address in one 
place in the DT. Otherwise, you should know the mask from the compatible 
string.

Rob
