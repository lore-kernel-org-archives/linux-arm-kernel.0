From: robherring2@gmail.com (Rob Herring)
Date: Wed, 19 Sep 2012 09:10:22 -0500
Subject: [PATCH V6 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <1347662517-4210-2-git-send-email-jon-hunter@ti.com>
References: <1347662517-4210-1-git-send-email-jon-hunter@ti.com>
 <1347662517-4210-2-git-send-email-jon-hunter@ti.com>
Message-ID: <5059D24E.20707@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/14/2012 05:41 PM, Jon Hunter wrote:
> This is based upon the work by Benoit Cousson [1] and Nicolas Ferre [2]
> to add some basic helpers to retrieve a DMA controller device_node and the
> DMA request/channel information.

[snip]

> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  Documentation/devicetree/bindings/dma/dma.txt |   81 +++++++++
>  drivers/of/Makefile                           |    2 +-
>  drivers/of/dma.c                              |  219 +++++++++++++++++++++++++

We've been moving in the direction of not putting subsystem related code
under drivers/of, but rather with the subsystem. Although in some cases
(i2c), the maintainers didn't want the OF code there.

In any case, I guess this will go thru Vinod's tree, so:

Acked-by: Rob Herring <rob.herring@calxeda.com>
