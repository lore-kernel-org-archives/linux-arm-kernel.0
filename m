From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 1 Dec 2014 11:50:06 +0100
Subject: [PATCH v3 05/11] memory: add Atmel EBI (External Bus Interface)
 driver
In-Reply-To: <19172687.eVxczUuuhC@ws-stein>
References: <1417429647-3419-1-git-send-email-boris.brezillon@free-electrons.com>
 <1417429647-3419-6-git-send-email-boris.brezillon@free-electrons.com>
 <19172687.eVxczUuuhC@ws-stein>
Message-ID: <20141201115006.08197c40@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

On Mon, 01 Dec 2014 11:40:03 +0100
Alexander Stein <alexander.stein@systec-electronic.com> wrote:

> Hi Boris,
> 
> On Monday 01 December 2014 11:27:21, Boris Brezillon wrote:
> > The EBI (External Bus Interface) is used to access external peripherals
> > (NOR, SRAM, NAND, and other specific devices like ethernet controllers).
> > Each device is assigned a CS line and an address range and can have its
> > own configuration (timings, access mode, bus width, ...).
> > This driver provides a generic DT binding to configure a device according
> > to its requirements.
> > For specific device controllers (like the NAND one) the SMC timings
> > should be configured by the controller driver through the matrix and
> > smc syscon regmaps.
> > 
> > Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >  drivers/memory/Kconfig     |  11 +
> >  drivers/memory/Makefile    |   1 +
> >  drivers/memory/atmel-ebi.c | 627 +++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 639 insertions(+)
> >  create mode 100644 drivers/memory/atmel-ebi.c
> 
> While I like this feature, shouldn't this driver go to drivers/bus/ like the imx-weim driver? The latter one does the same, so I wonder why one is in drivers/bus while the other is in drivers/memory.
> 

I don't have a strong opinion regarding where this driver should
live (I even considered putting it in drivers/bus) :-).
But note that there are other "external memory interface" drivers
in drivers/memory too: TI AEMIF and Marvell DEVBUS  ;-).

Does anyone else think this driver should go in drivers/bus ?

Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
