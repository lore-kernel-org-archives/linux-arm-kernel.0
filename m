From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 23 Aug 2013 15:55:56 -0600
Subject: [PATCH RFC v2 5/5] spmi: document the PMIC arbiter SPMI bindings
In-Reply-To: <ea2d30d47cb54b4322231f5c319663ee9c996784.1377202730.git.joshc@codeaurora.org>
References: <cover.1377202730.git.joshc@codeaurora.org>
 <ea2d30d47cb54b4322231f5c319663ee9c996784.1377202730.git.joshc@codeaurora.org>
Message-ID: <5217DA6C.4060903@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/2013 02:37 PM, Josh Cartwright wrote:

Patch description?

> diff --git a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt

> +Required properties:
> +- compatible : should be "qcom,spmi-pmic-arb".
> +- reg-names  : should be "core", "intr", "cnfg"

> +- reg : offset and length of the PMIC Arbiter Core register map.
> +- reg : offset and length of the PMIC Arbiter Interrupt controller register map.
> +- reg : offset and length of the PMIC Arbiter Configuration register map.

This seems like it's defining the "reg" property 3 times each with a
different meaning. It'd be better to say something like:

reg : register specifier. Must contain 3 entries, in the following
order: core registers, interrupt register, configuration registers.

> +	qcom,spmi at fc4c0000 {
...
> +		qcom,pm8841 at 4 {

Node names typically don't include a vendor prefix. For the first
instance above, I think just "spmi at fc4c0000" or even just "spmi" would
be appropriate here; the latter being best in the case where there's
only 1 SPMI controller and hence no need to include the unit address for
uniqueness.
