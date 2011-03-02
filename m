From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 2 Mar 2011 21:23:37 +0100
Subject: [PATCH v8 1/1] PRUSS UIO driver support
In-Reply-To: <20110302200956.GB23818@local>
References: <1299065886-30099-1-git-send-email-pratheesh@ti.com>
	<1299065886-30099-2-git-send-email-pratheesh@ti.com>
	<20110302200956.GB23818@local>
Message-ID: <201103022123.38050.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 March 2011 21:09:56 Hans J. Koch wrote:
> > +static struct uio_info *info;
> > +static dma_addr_t sram_paddr, ddr_paddr;
> > +static void *prussio_vaddr, *sram_vaddr, *ddr_vaddr;
> 
> So the correct thing would be
> 
> static void __iomem *prussio_vaddr;
> static void *sram_vaddr, *ddr_vaddr;

I also commented that it should not be a global variable at
all, but a dynamic data structure referenced from the device.

Not important, but Pratheesh said he'd change it. If it stays
a global variable, I'd at least expect an explanation why
the static variable is considered better in this case.

	Arnd
