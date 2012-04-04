From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Apr 2012 10:08:44 +0100
Subject: [PATCH] ARM: versatile: fix build failure in pci.c
In-Reply-To: <201204031426.22652.arnd@arndb.de>
References: <1333410505-17257-1-git-send-email-paul.gortmaker@windriver.com>
 <201204030819.48798.arnd@arndb.de> <4F7AFF61.3070803@windriver.com>
 <201204031426.22652.arnd@arndb.de>
Message-ID: <20120404090844.GS24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 03, 2012 at 02:26:22PM +0000, Arnd Bergmann wrote:
> On Tuesday 03 April 2012, Paul Gortmaker wrote:
> > I'm not sure I'm following you here. I'm not feeding the
> > struct pci_sys_data to pci_add_resource_offset.  Instead it
> > is getting subfields of it, consistent with the rest of the
> > original commit from Bjorn.
> 
> Sorry, my fault, I thought the suggestion was to pass sys into
> pci_add_resource_offset.
> 
> However, I would still prefer just reverting the versatile
> part of Bjorn's patch because versatile uses a zero offset.
> I think we should only pass the offset in cases where it's
> actually required because there are multiple buses or they
> have interesting mappings to the physical address space.

Or they do things the right way with IO space.
