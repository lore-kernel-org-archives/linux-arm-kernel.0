From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Jul 2012 16:25:58 +0000
Subject: [PATCH v2 10/15] ARM: kirkwood: use fixed PCI i/o mapping
In-Reply-To: <20120716071057.GB2163@lunn.ch>
References: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
 <1342231451-28861-11-git-send-email-robherring2@gmail.com>
 <20120716071057.GB2163@lunn.ch>
Message-ID: <201207161625.58768.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 July 2012, Andrew Lunn wrote:
> >       if (request_resource(&iomem_resource, &pp->res[1]))
> >               panic("Request PCIe%d Memory resource failed\n", index);
> >  
> > -     sys->io_offset = 0;
> > -     pci_add_resource_offset(&sys->resources, &pp->res[0], sys->io_offset);
> >       pci_add_resource_offset(&sys->resources, &pp->res[1], sys->mem_offset);
> 
> pp->res[0] is now unused. Do you plan to also clean up the PCI MEM
> space at some point? And then at the same time remove the rest of this
> code?

I think we still want the pci host drivers to register the resources for
the memory space. One thing is that they are not ioremapped at init
time, and also they typically have a nonzero offset.

	Arnd
