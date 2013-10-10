From: marex@denx.de (Marek Vasut)
Date: Thu, 10 Oct 2013 14:59:03 +0200
Subject: [PATCH v7 0/2] Add PCIe support for i.MX6q
In-Reply-To: <0E83723C55F66F43A6041464FE31119D408C77@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1380165887-13506-1-git-send-email-shawn.guo@linaro.org>
 <201310101225.10455.marex@denx.de>
 <0E83723C55F66F43A6041464FE31119D408C77@039-SN2MPN1-011.039d.mgd.msft.net>
Message-ID: <201310101459.04101.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

> Hi Marek
> Thanks for your kindly help on the i.MX6 PCIe switch debug.
> 
> I encountered random panic although I add the irq_map codes pasted before.
> Sometimes the switch + ep device can work well, but system maybe panic
> sometimes. :(

[...]

> VFS: Mounted root (nfs filesystem) on device 0:11.
> devtmpfs: mounted
> Freeing unused kernel memory: 300K (80c29000 - 80c74000)
> Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b  ?
> <--System panic here sometimes. :(

Looks like your init (program) exited in some way. Does this happen when you use 
the built-in ethernet controller too? Try booting with a ramdisk and generate 
large amounts of ethernet traffic (try with iperf), see if you observe a crash 
or corruption.

What kind of patch did you apply , can you share that patch ?

[...]

> Thanks for pointing this out, I'll check this. Are there plans to implement
> the PCIe switch support already so I won't step into someone else's work?
> 
> In the meantime, this is what I see upon probe with V6 of the patches:
> 
> Linux version 3.12.0-rc2-next-20130927+
> [...]
> imx6q-pcie 1ffc000.pcie: phy link never came up PCI host bridge to bus
> 0000:00 pci_bus 0000:00: root bus resource [io  0x1000-0x10000] pci_bus
> 0000:00: root bus resource [mem 0x01000000-0x01efffff] pci_bus 0000:00: No
> busn resource found for root bus, will use [bus 00-ff] PCI: bus0: Fast
> back to back transfers disabled
> PCI: bus1: Fast back to back transfers enabled
> PCI: Device 0000:00:00.0 not available because of resource collisions
> pcieport: probe of 0000:00:00.0 failed with error -22 pci 0000:00:00.0: BAR
> 0: assigned [mem 0x01000000-0x010fffff] pci 0000:00:00.0: BAR 6: assigned
> [mem 0x01100000-0x0110ffff pref] pci 0000:00:00.0: PCI bridge to [bus 01]
> pci 0000:00:00.0: PCI bridge to [bus 01]
> 
> Is this line normal/expected? Is this related to the PCIe switch I have
> there? pcieport: probe of 0000:00:00.0 failed with error -22

Any ideas on this stuff above please?

Best regards,
Marek Vasut
