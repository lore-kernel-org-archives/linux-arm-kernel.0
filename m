From: monstr@monstr.eu (Michal Simek)
Date: Tue, 12 Jul 2011 15:38:56 +0200
Subject: [PATCH v2 0/6] ARM: make mach/hardware.h optional
In-Reply-To: <201107121502.41570.arnd@arndb.de>
References: <1309366019-24379-1-git-send-email-robherring2@gmail.com>
	<201107021124.46953.arnd@arndb.de> <4E1B176E.3030503@gmail.com>
	<201107121502.41570.arnd@arndb.de>
Message-ID: <4E1C4E70.8030302@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> On Monday 11 July 2011, Rob Herring wrote:
>>> This is very good work, I really like it. I've mentioned one idea for
>>> an improvement in patch 5, which you can still integrate, but otherwise
>>>
>>> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>>>
>>> for the whole series.
>>>
>> I have an updated version ready to send out. Will you take this in your
>> tree including the 1st patch for pci flags functions? Also, what about
>> the powerpc conversion to generic pci flags?
> 
> I can take it all in the arm-soc tree, yes. However for anything outside
> of arch/arm/{mach,plat}-*, please get an Ack from the respective maintainer
> (Russell, Michal, BenH, ...).

Definitely not ACK for [PATH 1/6] because it breaks Microblaze PCI compilation.
Rob removed some parts from microblaze pci-bridge.h and didn't move them to 
generic location or keep them in it. Also didn't remove PCI 
bits(PCI_REASSIGN..., etc) from microblaze header. I have attached changed patch 
with Microblaze part.

I would also prefer to add to this patch fixes for PPC too. Microblaze pci code 
comes from PPC that's why will be the best to fix PPC in the same patch.
There should be one more patch for ppc which rename ppc_pci_flags to pci_flags + 
functions and bits

 From my point of view make sense do these patches.
1. (s/ppc_pci_flags/pci_flags/g) + (s/ppc_pci_/pci_/g) + (s/PPC_PCI_/PCI_/g)
2. introduce new asm-generic/pci-bridge.h with changes for microblaze and ppc
3. all others patches

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
