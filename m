From: jamie.iles@oracle.com (Jamie Iles)
Date: Mon, 25 Sep 2017 09:58:31 +0100
Subject: [PATCH] mtd: nand: gpio: Convert to use GPIO descriptors
In-Reply-To: <20170924173912.9199-1-linus.walleij@linaro.org>
References: <20170924173912.9199-1-linus.walleij@linaro.org>
Message-ID: <20170925085831.mamuitnvljrek3bo@cedar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 24, 2017 at 07:39:12PM +0200, Linus Walleij wrote:
> There is exactly one board in the kernel that defines platform data
> for the GPIO NAND driver.
> 
> Use the feature to provide a lookup table for the GPIOs in the board
> file so we can convert the driver as a whole to just use GPIO
> descriptors.
> 
> After this we can cut the use of <linux/of_gpio.h> and use the GPIO
> descriptor management from <linux/gpio/consumer.h> alone to grab and use
> the GPIOs used in the driver.
> 
> I also created a local struct device *dev in the probe() function
> because I was getting annoyed with all the &pdev->dev dereferencing.
> 
> Cc: arm at kernel.org
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: Frans Klaver <fransklaver@gmail.com>
> Cc: Gerhard Sittig <gsi@denx.de>

Acked-by: Jamie Iles <jamie.iles@oracle.com>
