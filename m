From: mjg59@srcf.ucam.org (Matthew Garrett)
Date: Mon, 6 Oct 2014 17:31:47 +0100
Subject: [PATCH 1/4] ata: ahci_platform: Add ACPI support for AMD Seattle
 SATA controller
In-Reply-To: <4872185.h11DQxW6kP@wuerfel>
References: <1410828446-28502-1-git-send-email-suravee.suthikulpanit@amd.com>
 <20140917012614.GA31214@srcf.ucam.org> <542C6FE9.10903@amd.com>
 <4872185.h11DQxW6kP@wuerfel>
Message-ID: <20141006163147.GA22482@srcf.ucam.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 02, 2014 at 10:39:18AM +0200, Arnd Bergmann wrote:

> I think part of the problem is that there is no specification for what
> an AHCI device should look like when it's not connected to a PCI
> bus, the AHCI document published by Intel just states:

One thing that has come out of further discussion on this - ACPI defines 
a _CLS object, which allows ACPI devices to declare compatibility with a 
PCI class device. We don't have support for it at the moment, but it 
would be easy enough to add this to the kernel and then just expose the 
AHCI PCI class via _CLS. That would avoid us having problems with people 
doing similar things with USB hosts.

-- 
Matthew Garrett | mjg59 at srcf.ucam.org
