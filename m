From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 14 Nov 2016 21:28:32 +0100
Subject: [PATCH RFC] ARM: dts: add support for Turris Omnia
In-Reply-To: <20161114201640.rr32iyjf5a53v33t@perseus.defre.kleine-koenig.org>
References: <20161105203841.9661-1-uwe@kleine-koenig.org>
 <1479126185.15557.5@smtp.gmail.com>
 <20161114201640.rr32iyjf5a53v33t@perseus.defre.kleine-koenig.org>
Message-ID: <20161114202832.GG24546@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> +               i2c at 7 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <7>;
> +
> +                       pcawan: gpio at 71 {
> +                               compatible = "nxp,pca9538";
> +                               reg = <0x71>;
> +
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&pcawan_pins>;
> +
> +                               interrupt-parent = <&gpio1>;
> +                               interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
> +
> +                               gpio-controller;
> +                               #gpio-cells = <2>;
> +
> +                               interrupt-controller;
> +                               #interrupt-cells = <2>;
> +                       };
> +               };
> 
> The interrupt-controller part doesn't seem to work though, at least
> 
> +               interrupt-parent = <&pcawan>;
> +               interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> 
> in the phy node gives an error.

Interrupts don't seem to work very well with the nxp,pca9538. Which
is probably why it is disabled by default.

   Andrew
