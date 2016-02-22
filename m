From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 22 Feb 2016 15:32:31 +0100
Subject: [PATCH 01/61] gpio: Add devm_ apis for gpiochip_add_data and
 gpiochip_remove
In-Reply-To: <1456150130-2668-2-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
 <1456150130-2668-2-git-send-email-ldewangan@nvidia.com>
Message-ID: <20160222143231.GB14970@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +/**
> + * devm_gpiochip_add_data() - Resource manager piochip_add_data()

                                                  ^
missing g.

> + * @dev: the device pointer on which irq_chip belongs to.
> + * @chip: the chip to register, with chip->base initialized
> + * Context: potentially before irqs will work
> + *
> + * Returns a negative errno if the chip can't be registered, such as
> + * because the chip->base is invalid or already associated with a
> + * different chip.  Otherwise it returns zero as a success code.
> + *
> + * The gpio chip automatically be released when the device is unbound.
                   ^
                    will

    Andrew
