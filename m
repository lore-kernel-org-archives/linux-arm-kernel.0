From: robherring2@gmail.com (Rob Herring)
Date: Fri, 06 Jul 2012 15:11:53 -0500
Subject: [PATCH 03/15] ARM: tegra: use fixed PCI i/o mapping
In-Reply-To: <4FF74028.6090300@wwwdotorg.org>
References: <1341600040-30993-1-git-send-email-robherring2@gmail.com>
 <1341600040-30993-4-git-send-email-robherring2@gmail.com>
 <4FF74028.6090300@wwwdotorg.org>
Message-ID: <4FF74689.8070103@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2012 02:44 PM, Stephen Warren wrote:
> On 07/06/2012 12:40 PM, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> Move tegra PCI to fixed i/o mapping and remove io.h.
> 
> Thierry, since you're the Tegra PCIe expert right now, could you please
> test and/or comment on this.
> 
> I did try testing this on next-20120705 on TrimSlice (i.e. the
> PCIe-based Ethernet controller), but found that PCIe has stopped working
> there due to "resource collisions". I know this used to work fairly
> recently, since I tested it when I added the PCIe initialization call to
> board-dt-tegra20.c. The PCIe messages are:

This is with my change and it works currently without?

The i/o mapping of the 2nd ctrlr looked a bit screwy to me. It's not
clear to me how an i/o address of 0x11000+ gets steered to the 2nd
controller.

Rob
> 
>> PCIE: port 1: link down, retrying
>> PCIE: port 1: link down, retrying
>> PCIE: port 1: link down, ignoring
>> PCI host bridge to bus 0000:00
>> pci_bus 0000:00: root bus resource [io  0x1000-0x8fff]
>> pci_bus 0000:00: root bus resource [mem 0x90000000-0x97ffffff]
>> pci_bus 0000:00: root bus resource [mem 0xa0000000-0xa7ffffff pref]
>> pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
>> pci_bus 0000:00: busn_res: [bus 00-ff] is inserted under domain [bus 00-ff]
>> pci 0000:00:00.0: [10de:0bf0] type 01 class 0x060000
>> pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
>> PCI: bus0: Fast back to back transfers disabled
>> pci_bus 0000:01: busn_res: [bus 01-ff] is inserted under [bus 00-ff]
>> pci 0000:01:00.0: [10ec:8168] type 00 class 0x020000
>> pci 0000:01:00.0: reg 10: [io  0x0000-0x00ff]
>> pci 0000:01:00.0: reg 18: [mem 0x00000000-0x00000fff 64bit pref]
>> pci 0000:01:00.0: reg 20: [mem 0x00000000-0x00003fff 64bit pref]
>> pci 0000:01:00.0: reg 30: [mem 0x00000000-0x0001ffff pref]
>> pci 0000:01:00.0: supports D1 D2
>> pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
>> PCI: bus1: Fast back to back transfers disabled
>> pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
>> pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 01
>> r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
>> PCI: Device 0000:01:00.0 not available because of resource collisions
>> r8169 0000:01:00.0: (unregistered net_device): enable failure
>> r8169: probe of 0000:01:00.0 failed with error -22
>> pci 0000:00:00.0: BAR 9: assigned [mem 0xa0000000-0xa00fffff pref]
>> pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
>> pci 0000:01:00.0: BAR 6: assigned [mem 0xa0000000-0xa001ffff pref]
>> pci 0000:01:00.0: BAR 4: assigned [mem 0xa0020000-0xa0023fff 64bit pref]
>> pci 0000:01:00.0: BAR 2: assigned [mem 0xa0024000-0xa0024fff 64bit pref]
>> pci 0000:01:00.0: BAR 0: assigned [io  0x1000-0x10ff]
>> pci 0000:00:00.0: PCI bridge to [bus 01]
>> pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
>> pci 0000:00:00.0:   bridge window [mem 0xa0000000-0xa00fffff pref]
>> PCI: enabling device 0000:00:00.0 (0140 -> 0143)
