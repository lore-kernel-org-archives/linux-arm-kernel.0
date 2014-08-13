From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 13 Aug 2014 11:53:58 +0100
Subject: [PATCH v9 12/12] PCI: Introduce pci_remap_iospace() for
 remapping PCI I/O bus resources into CPU space
In-Reply-To: <20140813103311.GQ25761@e106497-lin.cambridge.arm.com>
References: <1407860725-25202-1-git-send-email-Liviu.Dudau@arm.com>
 <1407860725-25202-13-git-send-email-Liviu.Dudau@arm.com>
 <20140813100118.GC18495@arm.com>
 <20140813103311.GQ25761@e106497-lin.cambridge.arm.com>
Message-ID: <20140813105358.GD18495@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 13, 2014 at 11:33:11AM +0100, Liviu Dudau wrote:
> On Wed, Aug 13, 2014 at 11:01:18AM +0100, Catalin Marinas wrote:
> > On Tue, Aug 12, 2014 at 05:25:25PM +0100, Liviu Dudau wrote:
> > > Introduce a default implementation for remapping PCI bus I/O resources
> > > onto the CPU address space. Architectures with special needs may
> > > provide their own version, but most should be able to use this one.
> > > 
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > 
> > I guess you could have added the generic pgprot_device definition to
> > this patch and the arm64 specific one in the separate arm64 PCIe support
> > (and one less patch in total). But not a big issue either way.
> 
> I went by the established history on that file, where a new interface gets
> introduced together with its use. I guess it makes backing out the change
> much easier?

The point is that the only user of pgprot_device is pci_remap_iospace()
currently, so it makes sense to introduce the generic definition
together with this patch.

-- 
Catalin
