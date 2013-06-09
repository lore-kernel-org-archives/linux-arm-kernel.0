From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 9 Jun 2013 16:21:02 +0200
Subject: [PATCH 2/2] ARM: nomadik: add the new clocks to the device tree
In-Reply-To: <1370775348-7440-2-git-send-email-linus.walleij@linaro.org>
References: <1370775348-7440-1-git-send-email-linus.walleij@linaro.org>
 <1370775348-7440-2-git-send-email-linus.walleij@linaro.org>
Message-ID: <201306091621.02506.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 09 June 2013, Linus Walleij wrote:
> +               /*
> +                * IP AMBA bus clocks, driving the bus side of the
> +                * peripheral clocking, clock gates.
> +                */
> +
> +               hclkdma0: hclkdma0 at 48M {
> +                       #clock-cells = <0>;
> +                       compatible = "st,nomadik-src-clock";
> +                       clock-id = <0>;
> +                       clocks = <&hclk>;
> +               };
> +               hclksmc: hclksmc at 48M {
> +                       #clock-cells = <0>;
> +                       compatible = "st,nomadik-src-clock";
> +                       clock-id = <1>;
> +                       clocks = <&hclk>;
> +               };
> +               hclksdram: hclksdram at 48M {
> +                       #clock-cells = <0>;
> +                       compatible = "st,nomadik-src-clock";
> +                       clock-id = <2>;
> +                       clocks = <&hclk>;
> +               };
> +               hclkdma1: hclkdma1 at 48M {
> +                       #clock-cells = <0>;
> +                       compatible = "st,nomadik-src-clock";
> +                       clock-id = <3>;
> +                       clocks = <&hclk>;
> +               };

Sorry if I'm being slow to understand how the clock bindings work, but if
you have 63 identical clocks that only differ in ther clock-id, can't you
just have a single DT node for them instead with #clock-cells=1 to pass the
number from the device using it?

	Arnd
