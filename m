From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 21 Sep 2012 08:41:12 +0200
Subject: [PATCH v4 1/5] gpio: introduce gpio-mvebu driver for Marvell SoCs
In-Reply-To: <1348087983-22309-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1348087983-22309-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1348087983-22309-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20120921064112.GC28177@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory

On Wed, Sep 19, 2012 at 10:52:58PM +0200, Thomas Petazzoni wrote:
> This driver aims at replacing the arch/arm/plat-orion/gpio.c driver,
> and is designed to be compatible with all Marvell EBU SoCs: Orion,
> Kirkwood, Dove, Armada 370/XP and Discovery.
> 
> It has been successfully tested on Dove and Armada XP at the moment.
> 
> Compared to the plat-orion driver, this new driver has the following
> added benefits:
> 
>  *) Support for Armada 370 and Armada XP
>  *) It is integrated with the mvebu pinctrl driver so that GPIO pins
>     are properly muxed, and the GPIO driver knows which GPIO pins are
>     output-only or input-only.
>  *) Properly placed in drivers/gpio
>  *) More extensible mechanism to support platform differences. The
>     plat-orion driver uses a simple mask-offset DT property, which
>     works fine for Discovery MV78200 but not for Armada XP. The new
>     driver uses different compatible strings to identify the different
>     variants of the GPIO controllers.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for incorporating my IRQ fix. I retested on Kirkwood. Please
add a

Tested-by: Andrew Lunn <andrew@lunn.ch>

	   Andrew
