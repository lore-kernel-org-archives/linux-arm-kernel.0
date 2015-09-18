From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Sep 2015 23:34:30 +0200
Subject: [PATCH v2 5/9] ARM: dts: Move all Cygnus peripherals into soc bus
In-Reply-To: <1442611454-16331-6-git-send-email-rjui@broadcom.com>
References: <1442611454-16331-1-git-send-email-rjui@broadcom.com>
 <1442611454-16331-6-git-send-email-rjui@broadcom.com>
Message-ID: <1929872.EmD9YkfFuv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 September 2015 14:24:10 Ray Jui wrote:
> +       soc {
> +               compatible = "simple-bus";
> +               ranges;
> +               #address-cells = <1>;
> +               #size-cells = <1>;

> +               pinctrl: pinctrl at 0301d0c8 {
> 

Similarly to the core bus, this seems to have address ranges 0x03xxxxxx and
0x18xxxxxx on it, so put those into the ranges.

It probably also makes sense to name the bus according to what kind of
bus (axi, ahb, plb, ...) is used here. If the soc has nested buses
(e.g. an ahb connected to an axi bus,) then model both of them in the DT.

	Arnd
