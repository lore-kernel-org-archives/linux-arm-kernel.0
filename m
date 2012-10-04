From: pza@pengutronix.de (Philipp Zabel)
Date: Thu, 4 Oct 2012 11:11:45 +0200
Subject: [PATCH v3 0/6] uio_pruss cleanup and platform support
In-Reply-To: <1349276133-26408-1-git-send-email-mporter@ti.com>
Message-ID: <20121004091145.GA3317@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matt,

On 10/3/12, Matt Porter <mporter@ti.com> wrote:
> This series enables uio_pruss on DA850 and removes use of the
> private SRAM API by the driver. The driver previously was not
> enabled by any platform and the private SRAM API was accessing
> an invalid SRAM bank.

have you seen my SRAM patch series at https://lkml.org/lkml/2012/9/7/281
"Add device tree support for on-chip SRAM" ?

I think the generic SRAM/genalloc driver (https://lkml.org/lkml/2012/9/7/282)
could be useful to map the L3RAM on Davinci.
With the gen_pool lookup patch (https://lkml.org/lkml/2012/9/7/284) the
uio_pruss driver could then use the gen_pool_find_by_phys() (or
of_get_named_gen_pool() for initialization from device tree) to
retrieve the struct gen_pool*.

This way you could avoid handing it over via platform data and you could
get rid of arch/arm/mach-davinci/{sram.c,include/mach/sram.h} completely.

regards
Philipp

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
