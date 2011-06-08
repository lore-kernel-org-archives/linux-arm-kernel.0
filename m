From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 8 Jun 2011 08:16:00 +0200
Subject: [RFC PATCH v3 2/2] dt: add custom device creation to platform bus
	scan
In-Reply-To: <4DEEE8AF.50603@gmail.com>
References: <1306359073-16274-1-git-send-email-robherring2@gmail.com>
	<201106012329.20651.arnd@arndb.de> <4DEEE8AF.50603@gmail.com>
Message-ID: <201106080816.00565.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 June 2011 05:12:47 Rob Herring wrote:
> The simplest solutions are usually the best. With that, the 2nd patch 
> becomes:
>
>   static int of_dev_node_match(struct device *dev, void *data)
>   {
> @@ -234,6 +235,11 @@ static int of_platform_bus_create(struct 
> device_node *bus,
>                  return 0;
>          }
> 
> +       if (of_device_is_compatible(bus, "arm,amba-device")) {
> +               of_amba_device_create(bus, parent);
> +               return 0;
> +       }
> +

Sounds good to me, just remind me what of_amba_device_create does when
amba is disabled. I guess it should do nothing in that case, there
can be no amba drivers loaded, so the device is clearly not needed.

	Arnd
