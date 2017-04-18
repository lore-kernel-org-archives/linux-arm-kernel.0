From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 19 Apr 2017 08:38:34 +1000
Subject: [PATCH v3 00/32] PCI: fix config and I/O Address space memory
 mappings
In-Reply-To: <20170418110350.GA1941@red-moon>
References: <1491952371.7236.22.camel@kernel.crashing.org>
 <20170412113124.GZ17774@n2100.armlinux.org.uk>
 <1492005119.7236.62.camel@kernel.crashing.org>
 <20170412141654.GA17774@n2100.armlinux.org.uk>
 <20170412144109.GB6842@red-moon>
 <1492036240.7236.80.camel@kernel.crashing.org>
 <20170412224555.GB17774@n2100.armlinux.org.uk>
 <1492044780.7236.87.camel@kernel.crashing.org>
 <20170418085732.GA23882@red-moon>
 <1492511808.25766.91.camel@kernel.crashing.org>
 <20170418110350.GA1941@red-moon>
Message-ID: <1492555114.25766.93.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-04-18 at 12:03 +0100, Lorenzo Pieralisi wrote:
> > The above would effectively disable mmap'ing of IO space for any
> > architecture that doesn't have pgprot_nonposted... so everybody
> > except
> > ARM. Thus breaking a number of systems that have been working fine
> > for
> > years.
> 
> pci_remap_iospace() is used on ARM/ARM64 only AFAICT I do not
> understand
> what I would actually break (and I am not sure at all how well PCI IO
> space is tested on ARM/ARM64 machines anyway).

My bad, I incorrectly assumed you were hacking the generic sysfs PCI
mapping.

Cheers,
Ben.
