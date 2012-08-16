From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Aug 2012 13:56:38 +0000
Subject: [PATCH 5/6] ARM: integrator: convert AMBA devices to device tree
In-Reply-To: <1345119373-22774-1-git-send-email-linus.walleij@linaro.org>
References: <1345119373-22774-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <201208161356.38997.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 August 2012, Linus Walleij wrote:
> +       fpga {
> +               compatible = "arm,amba-bus", "simple-bus";
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               rtc: rtc at 15000000 {
> +                       compatible = "arm,pl031", "arm,primecell";
> +                       reg = <0x15000000 0x1000>;
> +                       interrupt-parent = <&pic>;
> +                       interrupts = <8>;
> +                       arm,primecell-periphid = <0x00041030>;
> +               };
> +
> +               uart0: uart at 16000000 {
> +                       compatible = "arm,pl011", "arm,primecell";
> +                       reg = <0x16000000 0x1000>;
> +                       interrupt-parent = <&pic>;
> +                       interrupts = <1>;
> +                       arm,primecell-periphid = <0x00041010>;
> +               };
> +
> +               uart1: uart at 17000000 {
> +                       compatible = "arm,pl011", "arm,primecell";
> +                       reg = <0x17000000 0x1000>;
> +                       interrupt-parent = <&pic>;
> +                       interrupts = <2>;
> +                       arm,primecell-periphid = <0x00041010>;
> +               };

When all devices set the same interrupt-parent, you can just as well
move that property to the fpga node.

	Arnd
