From: julia@diku.dk (Julia Lawall)
Date: Wed, 1 Sep 2010 17:43:57 +0200 (CEST)
Subject: question about arch/arm/mach-iop13xx/include/mach/pci.h
Message-ID: <Pine.LNX.4.64.1009011740520.32566@ask.diku.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The file arch/arm/mach-iop13xx/include/mach/pci.h contains the following 
code:

#define IOP_PCI_STATUS_ERROR (PCI_STATUS_PARITY |            \
                               PCI_STATUS_SIG_TARGET_ABORT | \
                               PCI_STATUS_REC_TARGET_ABORT | \
                               PCI_STATUS_REC_TARGET_ABORT | \
                               PCI_STATUS_REC_MASTER_ABORT | \
                               PCI_STATUS_SIG_SYSTEM_ERROR | \
                               PCI_STATUS_DETECTED_PARITY)

This code contains two occurrences of PCI_STATUS_REC_TARGET_ABORT.  Can 
the second one just be dropped, or was it intended to include something 
else?

thanks,
julia
