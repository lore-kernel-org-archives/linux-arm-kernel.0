From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 27 Sep 2014 00:03:18 +0200
Subject: [PATCH] bcma: use device from DT (brcm,
 bus-gpio) for SoC GPIO chip
In-Reply-To: <1411741733-13888-1-git-send-email-zajec5@gmail.com>
References: <1411741733-13888-1-git-send-email-zajec5@gmail.com>
Message-ID: <2539898.4te2VKk57a@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 September 2014 16:28:53 Rafa? Mi?ecki wrote:
> +The top-level axi bus may contain following children:
> +
> +- gpio: GPIO chip on the SoC
> +
> +  Required properties:
> +  - compatible: "brcm,bus-gpio"
> +  - gpio-controller : makes the node a GPIO controller
> +  - #gpio-cells : size of the GPIO specifier, must be 2
> +
> 

I wonder if it would be better to avoid the subnode here and just
make the parent itself the gpio controller.

Is the gpio controller part of the bus itself in reality, or is it
a device that gets probed on the bus?

	Arnd
