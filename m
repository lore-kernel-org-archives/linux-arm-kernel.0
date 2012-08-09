From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 9 Aug 2012 11:48:42 +0000
Subject: How to get the irq flags from the dts file
In-Reply-To: <1344509006.2295.148.camel@tegra-chromium-2>
References: <1344509006.2295.148.camel@tegra-chromium-2>
Message-ID: <201208091148.42748.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 09 August 2012, Wei Ni wrote:
> In the wlan driver, it will use platform_get_resource() to get the
> res->irq, res->flags, the irq number is right, but the flags will be
> IORESOURCE_IRQ, not the 0x04 (IRQF_TRIGGER_HIGH).
> The wlan driver wish this flags include the IRQF_TRGGER_* information,
> and it will use this flags to configure other hw settings. If it is
> wrong, the wlan can't work.
> 
> I checked drivers/of/irq.c, in function of_irq_to_resource(), it will
> set r->flags = IORESOURCE_IRQ directly, not read the flags from the dtb
> file. And I didn't find any of_xx api to get this flags.
> 
> How can I get this flags, does anyone has suggestion?

The driver should not need to know about thie flag. It gets read
by irq_create_of_mapping when calling teh xlate function and
gets set using irq_set_irq_type from there too.

	Arnd
