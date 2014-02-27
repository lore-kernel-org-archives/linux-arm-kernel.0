From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 27 Feb 2014 12:31:55 +0000
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <20140226214843.GD12169@bivouac.eciton.net>
References: <20140226183454.GA14639@cbox> <5553754.0b4gMg5OS7@wuerfel>
 <20140226214843.GD12169@bivouac.eciton.net>
Message-ID: <alpine.DEB.2.02.1402271229370.31489@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Feb 2014, Leif Lindholm wrote:
> > >   no FDT.  In this case, the VM implementation must provide ACPI, and
> > >   the OS must be able to locate the ACPI root pointer through the UEFI
> > >   system table.
> > > 
> > > For more information about the arm and arm64 boot conventions, see
> > > Documentation/arm/Booting and Documentation/arm64/booting.txt in the
> > > Linux kernel source tree.
> > > 
> > > For more information about UEFI and ACPI booting, see [4] and [5].
> > 
> > What's the point of having ACPI in a virtual machine? You wouldn't
> > need to abstract any of the hardware in AML since you already know
> > what the virtual hardware is, so I can't see how this would help
> > anyone.
> 
> The point is that if we need to share any real hw then we need to use
> whatever the host has.

That's right.

I dislike ACPI as much as the next guy, but unfortunately if the host
only supports ACPI, the Linux driver for a particular device only works
together with ACPI, and you want to assign that device to a VM, then we
might be forced to use ACPI to describe it.
