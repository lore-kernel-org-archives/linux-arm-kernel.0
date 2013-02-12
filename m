From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Feb 2013 23:05:28 +0000
Subject: Giving special alignment/size constraints to the Linux PCI core?
In-Reply-To: <20130212193848.GE1471@obsidianresearch.com>
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
 <201302121902.14276.arnd@arndb.de>
 <20130212193848.GE1471@obsidianresearch.com>
Message-ID: <201302122305.28467.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 February 2013, Jason Gunthorpe wrote:
> PCI-E hotplug can be supported through the generic /sys/bus/pci/rescan
> mechanism, which forces a rediscovery/re-evaluation of all the buses
> in the system. The PCI core is smart enough to know what it can/can
> not reassign and can move the bridge windows around (IIRC most of the
> issues here are resolved these days?).
> 
> For PCI-E, the root port bridge can be placed anywhere in the host
> aperture, so as long as the host aperture isn't filled the core can
> allocate a memory region for the now active port.
> 
> Thomas's driver should support this as the regions and windows are all
> properly dynamic.

Ah, so you only allow hotplugging into the root ports, but not behind
additional bridges that have active devices on them, right?

I guess that is a common limitation for PCIe hotplugging.
 
> This is one reason why re-using the PCI core code is so desirable, it
> handles all these complexities.

Ok, I'm starting to understand what the entire discussion is about ;)

	Arnd
