From: grimaldi.ivan@gmail.com (Ivan Grimaldi)
Date: Thu, 14 Jul 2016 15:00:21 +0200
Subject: [PROBLEM]: pcie imx6 link problem after a random number of reboot
Message-ID: <CAO1575Vy6mMPWgXT_7Z2vkvpXU0jnxoJTNAiRPhTUuKmLQ1bLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

 I am having a problem with the iMX6 PCIe bus working, after a random
number of reboots i have a problem with pci link (below the kenel
log), the link is up but still in training.

The hardware and software configuration is the following:
1) Linux kernel 3.18.26
2) Custom board based on IMX6DL SoC

....
imx6q-pcie 1ffc000.pcie: Link is up, but still in training
imx6q-pcie 1ffc000.pcie: Link up, Gen=2
imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x1000-0xffff]
pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
pci_bus 0000:00: root bus resource [bus 00-ff]
pci_bus 0000:00: scanning bus
pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
pci 0000:00:00.0: calling pci_fixup_ide_bases+0x0/0x4c
pci 0000:00:00.0: supports D1
pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
pci 0000:00:00.0: PME# disabled
pci_bus 0000:00: fixups for bus
PCI: bus0: Fast back to back transfers disabled
pci 0000:00:00.0: scanning [bus 01-01] behind bridge, pass 0
pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
pci_bus 0000:01: scanning bus
imx6q-pcie 1ffc000.pcie: Link is up, but still in training
imx6q-pcie 1ffc000.pcie: Link is up, but still in training
imx6q-pcie 1ffc000.pcie: Link is up, but still in training
imx6q-pcie 1ffc000.pcie: Link is up, but still in training
imx6q-pcie 1ffc000.pcie: Link is up, but still in training
imx6q-pcie 1ffc000.pcie: transition to gen2 is stuck, reset PHY!
imx6q-pcie 1ffc000.pcie: debug_r0=0000060d debug_r1=28000410
pci_bus 0000:01: fixups for bus
PCI: bus1: Fast back to back transfers enabled
pci_bus 0000:01: bus scan returning with max=01
pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
pci_bus 0000:00: bus scan returning with max=01
pci 0000:00:00.0: fixup irq: got 155
pci 0000:00:00.0: assigning IRQ 155
pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
pci 0000:00:00.0: BAR 6: assigned [mem 0x01100000-0x0110ffff pref]
pci 0000:00:00.0: PCI bridge to [bus 01]
....

IVan
