From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 7 Jan 2013 19:43:39 +0000
Subject: [PATCH 3.9 1/3] misc: new driver for GPIO-connected 7-segment
 displays
In-Reply-To: <1357576928-29133-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1357576928-29133-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1357576928-29133-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <201301071943.40074.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 January 2013, Thomas Petazzoni wrote:

>  .../devicetree/bindings/misc/gpio-7seg.txt         |   18 +++
>  drivers/misc/Kconfig                               |   13 ++
>  drivers/misc/Makefile                              |    1 +
>  drivers/misc/gpio-7seg.c                           |  168 ++++++++++++++++++++

I wonder if it would make sense to merge this into the LED subsystem
rather than having it as a standalone driver.

> diff --git a/Documentation/devicetree/bindings/misc/gpio-7seg.txt b/Documentation/devicetree/bindings/misc/gpio-7seg.txt
> new file mode 100644
> index 0000000..107d178
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/gpio-7seg.txt
> @@ -0,0 +1,18 @@
> +* 7-segment driver connected over GPIO through a BCD decoder
> +
> +Required properties:
> +- compatible: "generic,gpio-7seg"
> +- gpios: list of GPIOs to use to control the 7-segment display

Maybe list the minimum and maximum number of gpio lines here?

> +	sdev->dev_attr.attr.name = "value";
> +	sdev->dev_attr.attr.mode = S_IRUGO | S_IWUGO;
> +	sdev->dev_attr.show = gpio_7seg_show;
> +	sdev->dev_attr.store = gpio_7seg_store;

Any reason why you are not using the DEVICE_ATTR macro?

	Arnd
