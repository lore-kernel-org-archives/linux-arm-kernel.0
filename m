From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Mar 2014 13:26:02 +0100
Subject: [PATCH v7 3/3] arm64: Add architecture support for PCI
In-Reply-To: <20140320113820.GH6457@e106497-lin.cambridge.arm.com>
References: <1394811258-1500-1-git-send-email-Liviu.Dudau@arm.com>
 <201403201217.22339.arnd@arndb.de>
 <20140320113820.GH6457@e106497-lin.cambridge.arm.com>
Message-ID: <201403201326.02377.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 March 2014, Liviu Dudau wrote:
> > I don't even understand why you want to create a generic pci_address_to_pio
> > implementation, when we don't need that for arm64 at all. Unless I'm
> > missing something important, that function is only called in case of
> > PCI_PROBE_DEVTREE with pci_of_scan on PowerPC. I don't expect any
> > architecture to do the same thing, and the only other architecture that
> > needs something like it (sparc) has a different implementation.
> 
> Because in my [v7 2/6]* patch for the generic host bridge support I start
> using pci_address_to_pio to fix the conversion of PCI ranges to resources.
> That requires an arm64 (or more correctly, an arch with memory mapped IO
> specific) version of pci_address_to_pio().

Yes, but why do you use it there?

	Arnd
