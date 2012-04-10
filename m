From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 10 Apr 2012 10:19:24 +0800
Subject: [PATCH 3/4] clk: add DT clock binding support
In-Reply-To: <1334003101-17274-4-git-send-email-robherring2@gmail.com>
References: <1334003101-17274-1-git-send-email-robherring2@gmail.com>
 <1334003101-17274-4-git-send-email-robherring2@gmail.com>
Message-ID: <20120410021922.GH18692@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 09, 2012 at 03:25:00PM -0500, Rob Herring wrote:
...
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/fixed-clock.txt
> @@ -0,0 +1,22 @@
> +Binding for simple fixed-rate clock sources.
> +
> +This binding uses the common clock binding[1].
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Required properties:
> +- compatible : shall be "fixed-clock".
> +- #clock-cells : from common clock binding; shall be set to 0.
> +- clock-frequency : frequency of clock in Hz. Should be a single cell.
						 ^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Optional properties:
> +- gpios : From common gpio binding; gpio connection to clock enable pin.

I haven't seen this support in the code yet.

> +- clock-output-names : From common clock binding. Required for nodes with
> +  multiple outputs.

This seems inconsistent with above "Should be a single cell."

Regards,
Shawn

> +
> +Example:
> +	clock {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <1000000000>;
> +	};
