From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Sun, 18 Mar 2018 15:50:29 -0700
Subject: [PATCH v4 2/7] dt-bindings: Introduce interconnect provider
 bindings
In-Reply-To: <20180309210958.16672-3-georgi.djakov@linaro.org>
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
 <20180309210958.16672-3-georgi.djakov@linaro.org>
Message-ID: <20180318225029.GQ5626@tuxbook-pro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 09 Mar 13:09 PST 2018, Georgi Djakov wrote:
> diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
[..]
> +Required properties:
> +- compatible : contains the interconnect provider vendor specific compatible
> +	       string
> +- reg : register space of the interconnect controller hardware

These properties doesn't relate to the interconnect provider, so there's
no need to describe them here.

> +
> +Examples:
> +
> +		snoc: snoc at 580000 {

These nodes should be described in a qcom/msm8916 binding document.

> +			compatible = "qcom,msm8916-snoc";
> +			reg = <0x580000 0x14000>;
> +			clock-names = "bus_clk", "bus_a_clk";
> +			clocks = <&rpmcc RPM_SMD_SNOC_CLK>, <&rpmcc RPM_SMD_SNOC_A_CLK>;
> +			status = "okay";
> +		};

Regards,
Bjorn
