From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 06 Oct 2014 20:19:37 +0200
Subject: [PATCH 1/4] ata: ahci_platform: Add ACPI support for AMD Seattle
 SATA controller
In-Reply-To: <20141006163147.GA22482@srcf.ucam.org>
References: <1410828446-28502-1-git-send-email-suravee.suthikulpanit@amd.com>
 <4872185.h11DQxW6kP@wuerfel> <20141006163147.GA22482@srcf.ucam.org>
Message-ID: <2026795.jAP8HDLAZo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 06 October 2014 17:31:47 Matthew Garrett wrote:
> On Thu, Oct 02, 2014 at 10:39:18AM +0200, Arnd Bergmann wrote:
> 
> > I think part of the problem is that there is no specification for what
> > an AHCI device should look like when it's not connected to a PCI
> > bus, the AHCI document published by Intel just states:
> 
> One thing that has come out of further discussion on this - ACPI defines 
> a _CLS object, which allows ACPI devices to declare compatibility with a 
> PCI class device. We don't have support for it at the moment, but it 
> would be easy enough to add this to the kernel and then just expose the 
> AHCI PCI class via _CLS. That would avoid us having problems with people 
> doing similar things with USB hosts.

Interesting. Does this also define a way to get access to registers
that are normally in PCI config space, provided they are accessible at
all?

I'm guessing that it's not extremely important, given that so far all
platforms are doing ok without the power management registers or MSI,
but I guess it would be nice if we could support those.

	Arnd
