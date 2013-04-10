From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 10 Apr 2013 12:43:37 -0700
Subject: [PATCH v7 1/5] drivers: memory: Introduce Marvell EBU Device Bus
 driver
In-Reply-To: <20130410191641.GG28693@titan.lakedaemon.net>
References: <1365620644-15790-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1365620644-15790-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130410191641.GG28693@titan.lakedaemon.net>
Message-ID: <20130410194337.GA5681@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 03:16:41PM -0400, Jason Cooper wrote:
> gregkh,
> 
> On Wed, Apr 10, 2013 at 04:04:00PM -0300, Ezequiel Garcia wrote:
> > Marvell EBU SoCs such as Armada 370/XP, Orion5x (88f5xxx) and
> > Discovery (mv78xx0) supports a Device Bus controller to access several
> > kinds of memories and I/O devices (NOR, NAND, SRAM, FPGA).
> > 
> > This commit adds a driver to handle this controller. So far only
> > Armada 370, Armada XP and Discovery SoCs are supported.
> > 
> > The driver must be registered through a device tree node;
> > as explained in the binding document.
> > 
> > For each child node in the device tree, this driver will:
> >   * set timing parameters
> >   * register a child device
> >   * setup an address decoding window, using the mbus driver
> > 
> > Keep in mind the address decoding window setup is only a temporary hack.
> > This code will be removed from this devbus driver as soon as a proper device
> > tree binding for the mbus driver is added.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  .../bindings/memory-controllers/mvebu-devbus.txt   | 156 ++++++++++
> >  drivers/memory/Kconfig                             |  10 +
> >  drivers/memory/Makefile                            |   1 +
> >  drivers/memory/mvebu-devbus.c                      | 340 +++++++++++++++++++++
> >  4 files changed, 507 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mvebu-devbus.txt
> >  create mode 100644 drivers/memory/mvebu-devbus.c
> 
> As every commit to drivers/memory has been signed by you, would you like
> to take this patch through your tree?  Or, I'll take it through arm-soc
> with your Ack to keep the series together.

Sure, feel free to take this through your tree and add:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
