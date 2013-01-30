From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Jan 2013 09:32:58 +0000
Subject: [PATCH v6 03/10] ARM: edma: add AM33XX support to the private
 EDMA API
In-Reply-To: <1359529229-22207-4-git-send-email-mporter@ti.com>
References: <1359529229-22207-1-git-send-email-mporter@ti.com>
 <1359529229-22207-4-git-send-email-mporter@ti.com>
Message-ID: <201301300932.58732.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 January 2013, Matt Porter wrote:
> +               dma_cap_set(DMA_SLAVE, edma_filter_info.dma_cap);
> +               of_dma_controller_register(dev->of_node,
> +                                          of_dma_simple_xlate,
> +                                          &edma_filter_info);
> +       }

How do you actually deal with the problem mentioned by Padma, that
the filter function does not know which edma instance it is looking
at? If you assume that there can only be a single edma instance in
the system, that is probably a limitation that should be documented
somewhere, and ideally the probe() function should check for that.

	Arnd
