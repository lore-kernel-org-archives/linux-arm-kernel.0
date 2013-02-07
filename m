From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Feb 2013 09:09:26 +0000
Subject: [PATCH v2 22/27] arm: mvebu: add PCIe Device Tree informations
 for Armada XP
In-Reply-To: <20130207094556.423de279@skate>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201302070804.12256.arnd@arndb.de> <20130207094556.423de279@skate>
Message-ID: <201302070909.26701.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 February 2013, Thomas Petazzoni wrote:
> Unfortunately, this means the windows are statically defined in the DT,
> which is simply not possible for PCIe, as we have already explained
> several times in this thread.
> 
> Any solution where the PCIe windows are statically described is
> simply not acceptable.
> 
> We have 10 PCIe interfaces, each requiring up to two windows, and we
> have on the system a total of 20 windows. Doing static assignments of
> windows is simply not an option.
> 
> Of course, you'll tell me that it's up to each board .dts to have a
> number of windows that matches the number of actually existing PCIe
> interface. But it means that each and every developer adding the
> support for a new board must understand this complex problem, which is
> something we do not want. We have a solution that makes all of this
> PCIe window assignment dynamic, so it surprises me that we have to
> continue to explain why a static solution is not appropriate.

No, the idea here was actually to leave out any of the dynamic mappings
from the device tree and do the PCI bus probe for each port based
on a local bus address starting at 0 for each port. After all
BARs are assigned, you can then map each port to a convenient physical
address and register it by passing the start offset so that the
pci resources are adapted correctly.

	Arnd
