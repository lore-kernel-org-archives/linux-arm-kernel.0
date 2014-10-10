From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 10 Oct 2014 12:08:27 +0200
Subject: [PATCH V4 5/7] ARM: dts: Enable Broadcom Cygnus SoC
In-Reply-To: <1412894671-5921-6-git-send-email-sbranden@broadcom.com>
References: <1412894671-5921-6-git-send-email-sbranden@broadcom.com>
Message-ID: <6003834.vKPhBNUdsz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 09 October 2014 15:44:29 Scott Branden wrote:
> +
> +               lcpll: lcpll at 0301d02c {
> +                       #clock-cells = <0>;
> +                       compatible = "brcm,cygnus-lcpll-clk";
> +                       reg = <0x0301d02c 0x1c>;
> +                       clocks = <&osc>;
> +               };
> +
> +               genpll: genpll at 0301d000 {
> +                       #clock-cells = <0>;
> +                       compatible = "brcm,cygnus-genpll-clk";
> +                       reg = <0x0301d000 0x2c>,
> +                                 <0x180AA024 0x4>,
> +                                 <0x0301C020 0x4>;
> +                       clocks = <&osc>;
> +               };
> +

To be honest, I'm not too happy about the way you specify a single
register for each clock as a global 'reg' property.

Presumably each of these registers is part of an IP block that does
multiple things, so it would be better to start out with a binding
for each IP block. How many of these blocks are used for clocks, and
what do they do?

	Arnd
