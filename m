From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Wed, 13 Aug 2014 11:33:11 +0100
Subject: [PATCH v9 12/12] PCI: Introduce pci_remap_iospace() for
 remapping PCI I/O bus resources into CPU space
In-Reply-To: <20140813100118.GC18495@arm.com>
References: <1407860725-25202-1-git-send-email-Liviu.Dudau@arm.com>
 <1407860725-25202-13-git-send-email-Liviu.Dudau@arm.com>
 <20140813100118.GC18495@arm.com>
Message-ID: <20140813103311.GQ25761@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 13, 2014 at 11:01:18AM +0100, Catalin Marinas wrote:
> On Tue, Aug 12, 2014 at 05:25:25PM +0100, Liviu Dudau wrote:
> > Introduce a default implementation for remapping PCI bus I/O resources
> > onto the CPU address space. Architectures with special needs may
> > provide their own version, but most should be able to use this one.
> > 
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> 
> I guess you could have added the generic pgprot_device definition to
> this patch and the arm64 specific one in the separate arm64 PCIe support
> (and one less patch in total). But not a big issue either way.

I went by the established history on that file, where a new interface gets
introduced together with its use. I guess it makes backing out the change
much easier?

Best regards,
Liviu

> 
> -- 
> Catalin

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
