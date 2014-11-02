From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Mon, 03 Nov 2014 00:37:08 +0100
Subject: PCIe host controller without IO port access.
Message-ID: <5456C024.4060103@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am currently writing a driver for a PCIe host controller which does
not support IO port access.

My plan was to only provide IORESOURCE_MEM to pci_sys_data->resources,
but then it allocates some generic IORESOURCE_IO memory in
arch/arm/kernel/bios32.c:pcibios_init_resources(). This will work for
the fist PCIe controller, but when the second controller gets registered
I am getting this: "unable to allocate I/O port region (-16)".

Is there an example for an arm driver for a PCIe controller which does
not support IO port access?

Should I change arch/arm/kernel/bios32.c in a way so that it would
ignore the io port mem?

Hauke
