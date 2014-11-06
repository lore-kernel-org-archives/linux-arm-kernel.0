From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 06 Nov 2014 01:05:48 +0100
Subject: [RFC 2/4] PCI: generic: Add support for ARM64 and MSI(x)
In-Reply-To: <20141105233921.GJ6168@google.com>
References: <1411937610-22125-1-git-send-email-suravee.suthikulpanit@amd.com>
 <2148776.X8NPqiYA6S@wuerfel> <20141105233921.GJ6168@google.com>
Message-ID: <2659321.LYB03rL97X@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 05 November 2014 16:39:21 Bjorn Helgaas wrote:
> On Wed, Oct 22, 2014 at 10:52:19PM +0200, Arnd Bergmann wrote:
> > On Wednesday 22 October 2014 16:59:14 Lorenzo Pieralisi wrote:
> > > On Wed, Oct 01, 2014 at 10:38:45AM +0100, Arnd Bergmann wrote:
> > > 
> > > [...]
> > > 
> > > > The arm32 implementations of pci_domain_nr/pci_proc_domain can probably be
> > > > removed if we change the arm32 pcibios_init_hw function to call the new
> > > > interfaces that set the domain number.
> > > 
> > > I wished, but it is a bit more complicated than I thought unfortunately,
> > > mostly because some drivers, eg cns3xxx set the domain numbers
> > > statically in pci_sys_data and this sets a chain of dependency that is
> > > not easy to untangle. I think cns3xxx is the only legacy driver that "uses"
> > > the domain number (in pci_sys_data) in a way that clashes with the
> > > generic domain_nr implementation, I need to give it more thought.
> > 
> > Just had a look at that driver, shouldn't be too hard to change, see below.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> This patch is in my patchwork, but it lacks a topic & changelog and I'm not
> sure of its state, so I'm going to drop it for now.  Please post it again
> if you want me to do something with it.  I guess it only touches arch/arm,
> so it would probably be merged via your tree anyway.

Lorenzo has posted an updated version as

"arm: cns3xxx: pci: remove artificial dependency on pci_sys_data domain",
and a second patch that depends on it. That is the version we should be
merging, though I'm not sure through which tree.

	Arnd
