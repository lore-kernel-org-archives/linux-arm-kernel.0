From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 8 Jul 2012 16:35:30 +0000
Subject: [PATCH 03/15] ARM: tegra: use fixed PCI i/o mapping
In-Reply-To: <4FF99688.1040703@gmail.com>
References: <1341600040-30993-1-git-send-email-robherring2@gmail.com>
 <20120708060932.GB5186@avionic-0098.mockup.avionic-design.de>
 <4FF99688.1040703@gmail.com>
Message-ID: <201207081635.30864.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 08 July 2012, Rob Herring wrote:
> > I'm not very familiar with the inner workings of the iotable and the
> > mappings initialized by it, but I wonder if this can be done dynamically
> > at a later stage. The way this is currently done in this patch, the I/O
> > region is statically mapped from a fixed offset within the PCIe address
> > range. Part of the patches to add DT support is to allow this region to
> > be defined by the DT, so that will obviously also create problems.
> 
> Is the i/o address something you could extract from DT earlier? This can
> be done separately if it doesn't require information from the driver.
> 
> I'm sure exactly how to do a fixed virtual mapping other than the
> io_table mappings. There was some discussion of use fixmap region
> previously, but doing so will be a bit more complex. I'll look into this
> some.

I think you can call ioremap_page_range() to do this.

	Arnd
