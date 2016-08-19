From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 18 Aug 2016 17:28:26 -0700
Subject: [PATCH v6 2/2] clk: uniphier: add clock data for UniPhier SoCs
In-Reply-To: <1470112223-24835-3-git-send-email-yamada.masahiro@socionext.com>
References: <1470112223-24835-1-git-send-email-yamada.masahiro@socionext.com>
 <1470112223-24835-3-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20160819002826.GT361@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02, Masahiro Yamada wrote:
> diff --git a/Documentation/devicetree/bindings/clock/uniphier-clock.txt b/Documentation/devicetree/bindings/clock/uniphier-clock.txt
> new file mode 100644
> index 0000000..1a4db8b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/uniphier-clock.txt
> @@ -0,0 +1,134 @@
> +UniPhier clock controller
> +
> +
> +System clock
> +------------
> +
> +Required properties:
> +- compatible: should be one of the following:
> +    "socionext,uniphier-sld3-clock" - for PH1-sLD3 SoC.
> +    "socionext,uniphier-ld4-clock"  - for PH1-LD4 SoC.
> +    "socionext,uniphier-pro4-clock" - for PH1-Pro4 SoC.
> +    "socionext,uniphier-sld8-clock" - for PH1-sLD8 SoC.
> +    "socionext,uniphier-pro5-clock" - for PH1-Pro5 SoC.
> +    "socionext,uniphier-pxs2-clock" - for ProXstream2/PH1-LD6b SoC.
> +    "socionext,uniphier-ld11-clock" - for PH1-LD11 SoC.
> +    "socionext,uniphier-ld20-clock" - for PH1-LD20 SoC.
> +- #clock-cells: should be 1.
> +
> +Example:
> +
> +	sysctrl at 61840000 {
> +		compatible = "socionext,uniphier-ld20-sysctrl",
> +			     "simple-mfd", "syscon";
> +		reg = <0x61840000 0x4000>;
> +
> +		clock {
> +			compatible = "socionext,uniphier-ld20-clock";
> +			#clock-cells = <1>;
> +		};
> +
> +		other nodes ...

What are the other nodes? Is there a document for the rest of the
MFD?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
