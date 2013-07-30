From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 Jul 2013 23:23:16 +0200
Subject: NSA310 + DT
In-Reply-To: <51F814A0.2050403@uni-bremen.de>
References: <20130710073706.GA28212@lunn.ch> <51F6A0DC.3020501@uni-bremen.de>
 <20130729192112.GY29916@titan.lakedaemon.net>
 <20130729204315.GK24782@lunn.ch> <51F78DA6.8010307@uni-bremen.de>
 <20130730144752.GR24782@lunn.ch> <20130730172407.3aab15c6@skate>
 <51F7EBB9.7000504@uni-bremen.de> <20130730191943.49f8070c@skate>
 <20130730183610.GT24782@lunn.ch> <51F814A0.2050403@uni-bremen.de>
Message-ID: <20130730232316.10dc7019@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Finn Hoffmann,

On Tue, 30 Jul 2013 21:31:44 +0200, Finn Hoffmann wrote:
> # cat /sys/kernel/debug/mvebu-mbus/devices
> [00] 00000000e8010000 - 00000000e8020000 : pcie0.0 (remap 0000000000010000)
> [01] disabled
> [02] disabled
> [03] disabled
> [04] 00000000f4000000 - 00000000f4010000 : nand
> [05] 00000000f5000000 - 00000000f5010000 : sram
> [06] 00000000fff00000 - 0000000100000000 : pcie0.0

Ok, now we have a memory window created, which looks better, but its
addresses are wrong.

> mvebu-pcie pcie-controller.1: PCIe0.0: link up
> mvebu-pcie pcie-controller.1: PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [io 0x1000-0xfffff]
> pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]
> pci_bus 0000:00: root bus resource [bus 00-ff]
> PCI: bus0: Fast back to back transfers disabled
> pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> PCI: bus1: Fast back to back transfers disabled
> MVEBU PCI 0.0: new pref mem, base 0xfff0, limit 0xfff0
> MVEBU PCI 0.0: new pref mem, base 0x0, limit 0x0
> mvebu_mbus: cannot add window 'pcie0.0', conflicts with another window
> pci 0000:00:01.0: BAR 9: assigned [mem 0xe0000000-0xe00fffff pref]
> pci 0000:00:01.0: BAR 7: assigned [io 0x10000-0x10fff]
> pci 0000:01:00.0: BAR 6: assigned [mem 0xe0000000-0xe000ffff pref]
> pci 0000:01:00.0: BAR 4: assigned [mem 0xe0010000-0xe0013fff 64bit pref]
> pci 0000:01:00.0: BAR 2: assigned [mem 0xe0014000-0xe0014fff 64bit pref]
> pci 0000:01:00.0: BAR 0: assigned [io 0x10000-0x100ff]
> pci 0000:00:01.0: PCI bridge to [bus 01]
> pci 0000:00:01.0: bridge window [io 0x10000-0x10fff]
> MVEBU PCI 0.0: new io, base 0x1, limit 0x1
> MVEBU PCI 0.0: new mem, base 0xfff0, limit 0x0
> pci 0000:00:01.0: bridge window [mem 0xe0000000-0xe00fffff pref]
> MVEBU PCI 0.0: new pref mem, base 0xe000, limit 0xe000
> mvebu_mbus: cannot add window 'pcie0.0', conflicts with another window

Thanks for this log. I need a bit of time to analyze this with the
PCI-to-PCI bridge specification, and I'll cook up a new patch,
hopefully tomorrow.

Thanks again a lot for taking the time to report this bug and test the
patches,

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
