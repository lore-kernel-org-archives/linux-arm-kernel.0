From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 6 Apr 2013 15:05:33 +0200
Subject: [PATCH v3 1/5] drivers: memory: Introduce Marvell EBU Device Bus
 driver
In-Reply-To: <1365246930-13315-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1365246930-13315-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1365246930-13315-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <201304061505.33946.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 06 April 2013, Ezequiel Garcia wrote:

> + - devbus,dev-width:    0x0 = 8-bit
> +                        0x1 = 16-bit
> +                        0x2 = 32-bit
> +                        0x3 = Reserved

I think by convention this should be called "bus-width" and allow the
values <8>, <16> and <32>, each referrring to the width in bits.

> +/* Perhaps it makes sense to unify both compatible strins? */
> +static const struct of_device_id mvebu_devbus_of_match[] = {
> +	{ .compatible = "marvell,armada370-devbus"	 },
> +	{ .compatible = "marvell,armadaxp-devbus"	 },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mvebu_devbus_of_match);

Yes, if the hardware behaves identically and all the differences are
described in the other properties, just name it after the first soc
that had this devbus.

	Arnd
