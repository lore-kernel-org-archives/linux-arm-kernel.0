From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 06 Oct 2014 20:44:35 +0200
Subject: [PATCH 1/4] ata: ahci_platform: Add ACPI support for AMD Seattle
 SATA controller
In-Reply-To: <20141006182153.GA31521@srcf.ucam.org>
References: <1410828446-28502-1-git-send-email-suravee.suthikulpanit@amd.com>
 <2026795.jAP8HDLAZo@wuerfel> <20141006182153.GA31521@srcf.ucam.org>
Message-ID: <2046349.jdtgG25KJR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 06 October 2014 19:21:53 Matthew Garrett wrote:
> On Mon, Oct 06, 2014 at 08:19:37PM +0200, Arnd Bergmann wrote:
> 
> > Interesting. Does this also define a way to get access to registers
> > that are normally in PCI config space, provided they are accessible at
> > all?
> 
> Unfortunately not. I'd assume that PM registers are expected to be 
> accessed via the _PS* methods instead. Does MSI make sense outside the 
> context of PCI interrupts?

Yes, the ARM GIC has a weird sense of what MSI is used for, and
apparently some SoC vendors have started using MSI by default for
all on-chip peripherals.

A patch series to extend MSI to platform devices is currently
under review.

	Arnd
