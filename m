From: robherring2@gmail.com (Rob Herring)
Date: Sun, 02 Sep 2012 17:59:10 -0500
Subject: [PATCH 4/6 v2] ARM: integrator: initial device tree support
In-Reply-To: <1346471760-23993-4-git-send-email-linus.walleij@linaro.org>
References: <1346471760-23993-1-git-send-email-linus.walleij@linaro.org>
 <1346471760-23993-2-git-send-email-linus.walleij@linaro.org>
 <1346471760-23993-3-git-send-email-linus.walleij@linaro.org>
 <1346471760-23993-4-git-send-email-linus.walleij@linaro.org>
Message-ID: <5043E4BE.1060508@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/31/2012 10:55 PM, Linus Walleij wrote:
> This is initial device tree support for the ARM Integrator family,
> we create a very basic device tree, #ifdef out the non-DT machines
> when compiling for device tree.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Also switch over clocksource and clockevent to device tree.
>   Else the IRQ mapping goes bananas.
> ---

snip

> +++ b/arch/arm/boot/dts/integratorcp.dts
> @@ -0,0 +1,69 @@
> +/*
> + * Device Tree for the ARM Integrator/CP platform
> + */
> +
> +/dts-v1/;
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	model = "ARM Integrator/CP";
> +	compatible = "arm,integrator-cp";
> +	ranges;
> +
> +	aliases {
> +		arm,integrator-clocksource = &timer2;
> +		arm,integrator-clockevent = &timer1;

This is linux specific and a common issue we need a solution for. Grant
had done something for versatile and we discussed it some, but nothing
ever got close to finalized. IIRC, Grant's solution was just add a
"linux,clockevent" or "linux,clocksource" to the nodes that are to be
used. But he wasn't really happy with it. Perhaps using these names as
aliases would be better.

Rob
