From: jszhang@marvell.com (Jisheng Zhang)
Date: Sun, 12 Jun 2016 20:32:45 +0800
Subject: [RFC] implement gpio_pci_platform_pm to put pci device into D3cold
Message-ID: <20160612203245.66fbd54a@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear all,

I want to solve one problem: we have pcie in a DT based arm64 system, now we
want to put the device into D3cold when runtime suspended. The pcie
device could be power down by operating one gpio pin, this is the D3cold the
platform could support. 

My solution is to register a gpio_pci_platform_pm with pci_set_platform_pm()
but the key is how to setup a mapping between pci_dev and gpio through DT

I think this is a general case, could you please kindly give some suggestions?

Thanks,
Jisheng
