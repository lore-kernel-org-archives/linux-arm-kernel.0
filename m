From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Oct 2015 17:09:56 +0200
Subject: [PATCH v4 3/5] PCI: generic: Quit clobbering our pci_ops.
In-Reply-To: <20151008150215.GB3885@localhost>
References: <1443811443-18878-1-git-send-email-ddaney.cavm@gmail.com>
 <1443811443-18878-4-git-send-email-ddaney.cavm@gmail.com>
 <20151008150215.GB3885@localhost>
Message-ID: <5128429.u9O5dh5qKB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 October 2015 10:02:16 Bjorn Helgaas wrote:
> [+cc Arnd]
> 
> Arnd, you had comments on the previous version.  What do you think of
> this one?

Looks good to me

> On Fri, Oct 02, 2015 at 11:44:01AM -0700, David Daney wrote:
> > From: David Daney <david.daney@cavium.com>
> > 
> > The pci-host-generic driver keeps a global struct pci_ops which it
> > then patches with the .map_bus method appropriate for the bus device.
> > A problem arises when the driver is used for two different types of
> > bus devices, the .map_bus method for the last device probed clobbers
> > the method for all previous devices.  The result, only the last bus
> > device probed has the proper .map_bus, and the others fail.
> > 
> > Move the struct pci_ops into the bus specific structure, and
> > initialize a pointer to it when the bus device is probed.
> > 
> > Acked-by: Will Deacon <will.deacon@arm.com>
> > Signed-off-by: David Daney <david.daney@cavium.com>
> 

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
