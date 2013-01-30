From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 29 Jan 2013 23:38:30 -0500
Subject: [PATCH 3/5] serial: pl011: use generic DMA slave configuration
 if possible
In-Reply-To: <1359410300-26113-4-git-send-email-arnd@arndb.de>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <1359410300-26113-1-git-send-email-arnd@arndb.de>
 <1359410300-26113-4-git-send-email-arnd@arndb.de>
Message-ID: <20130130043830.GB30002@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 09:58:18PM +0000, Arnd Bergmann wrote:
> With the new OF DMA binding, it is possible to completely avoid the
> need for platform_data for configuring a DMA channel. In cases where the
> platform has already been converted, calling dma_request_slave_channel
> should get all the necessary information from the device tree.
> 
> This also adds a binding document specific to the pl011 controller,
> and extends the generic primecell binding to mention "dmas" and other
> common properties.
> 
> Like the patch that converts the dw_dma controller, this is completely
> untested and is looking for someone to try it out.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: spi-devel-general at lists.sourceforge.net
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Vinod Koul <vinod.koul@linux.intel.com>
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: linux-arm-kernel at lists.infradead.org

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
