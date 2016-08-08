From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 08 Aug 2016 23:32:46 +0200
Subject: [PATCH 1/4] soc: qcom: add an EBI2 device tree bindings
In-Reply-To: <1470691445-27571-2-git-send-email-linus.walleij@linaro.org>
References: <1470691445-27571-1-git-send-email-linus.walleij@linaro.org>
 <1470691445-27571-2-git-send-email-linus.walleij@linaro.org>
Message-ID: <2988918.zNxvaGl6en@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, August 8, 2016 11:24:02 PM CEST Linus Walleij wrote:
> +
> +Required subnode properties:
> +- chipselect: <N> where N is the chipselect configured in this node
> +- address-cells: should be <1>
> +- size-cells: should be <1>
> +- ranges: bool should be present
> 

I think this should use a proper ranges property that translates
the address space of the external bus into the parent bus.

Just use #address-cells=<2> and make the first cell the cs number,
as the other similar drivers do, and get rid of the chipselect
property.

	Arnd
