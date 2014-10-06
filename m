From: mjg59@srcf.ucam.org (Matthew Garrett)
Date: Mon, 6 Oct 2014 19:47:25 +0100
Subject: [PATCH 1/4] ata: ahci_platform: Add ACPI support for AMD Seattle
 SATA controller
In-Reply-To: <2046349.jdtgG25KJR@wuerfel>
References: <1410828446-28502-1-git-send-email-suravee.suthikulpanit@amd.com>
 <2026795.jAP8HDLAZo@wuerfel> <20141006182153.GA31521@srcf.ucam.org>
 <2046349.jdtgG25KJR@wuerfel>
Message-ID: <20141006184725.GA1152@srcf.ucam.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 06, 2014 at 08:44:35PM +0200, Arnd Bergmann wrote:
> On Monday 06 October 2014 19:21:53 Matthew Garrett wrote:
> > Unfortunately not. I'd assume that PM registers are expected to be 
> > accessed via the _PS* methods instead. Does MSI make sense outside the 
> > context of PCI interrupts?
> 
> Yes, the ARM GIC has a weird sense of what MSI is used for, and
> apparently some SoC vendors have started using MSI by default for
> all on-chip peripherals.
> 
> A patch series to extend MSI to platform devices is currently
> under review.

Mm. Yeah, it doesn't seem like there's any ACPI-defined mechanism for 
MSI control. Let's chat about this next week?

-- 
Matthew Garrett | mjg59 at srcf.ucam.org
