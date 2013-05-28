From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 28 May 2013 11:27:13 -0400 (EDT)
Subject: [PATCH V8 3/3] USB: OHCI: make ohci-pci a separate driver
In-Reply-To: <1369746291-21788-4-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1305281126340.1030-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 May 2013, Manjunath Goudar wrote:

> This patch splits the PCI portion of ohci-hcd out into its
> own separate driver module, called ohci-pci.
> 
> The major point of difficulty lies in ohci-pci's many vendor- and
> device-specific workarounds.  Some of them have to be applied before
> calling ohci_start() some after, which necessitates a fair amount of
> code motion.  The other platform drivers require much smaller changes.
> 
> The complete sb800_prefetch() function moved to ohci-q.c,because its
> only related to ohci-pci driver.
> 
> USB_OHCI_HCD_PCI symbol no longer dependence on STB03xxx, PPC_MPC52xx and
> USB_OHCI_HCD_PPC_OF that's what removed.
> 
> V2:
>   - few specific content of pci related code in ohci_pci_start function has been moved to ohci_pci_reset
>     and rest of the generic code is written in ohci_start of ohci-hcd.c file.
> V3:
>  - ohci_restart() has been called in ohci_pci_reset() function for to reset the ohci pci.
> 
> V4:
>  -sb800_prefetch() moved to ohci-q.c,because its only related to ohci-pci.
>  -no longer _creating_ CONFIG_USB_OHCI_PCI,creating CONFIG_USB_OHCI_HCD_PCI.
>  -overrides renamed with pci_override,its giving proper meaning.
> 
> V5:
>  -sb800_prefetch() moved to pci-quirks.c,because its only related to pci.
> 
> V6:
>  -sb800_prefetch() function has been moved to pci-quirks.c made as separate patch in 2/3.
>  -Most of the generic ohci pci changes moved in 2/3 patch,now this is complete  ohci-pci separation patch.
> 
> V7:
>  -Unrelated include file has been removed from ohci.h file.
> 
> V8:
>  -USB_OHCI_HCD_PCI symbol does not dependence on STB03xxx, PPC_MPC52xx and USB_OHCI_HCD_PPC_OF.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
