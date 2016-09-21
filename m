From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Sep 2016 10:10:58 +0200
Subject: [GIT PULL] ARM: mvebu: soc for v4.9 (#1)
In-Reply-To: <87eg4e5xop.fsf@free-electrons.com>
References: <87bmzqbilu.fsf@free-electrons.com> <5238448.m4YaC7vVme@wuerfel>
 <87eg4e5xop.fsf@free-electrons.com>
Message-ID: <4634141.55loc00AVg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, September 20, 2016 6:43:34 PM CEST Gregory CLEMENT wrote:
> 
> Do you mean board-wnr854t.c?

Yes.
 
> If it is the case then I can just drop the patch adding this file because
> the only things done in this file are about the PCI.

Ah, that's perfect. Just for more background, I think it shouldn't be too
hard to convert the existing orion5x PCI support into a proper host driver,
and I can assist anyone willing to work on this and test it.

I think the steps here would roughly be:

- change PCI (not PCIe) host initialization to call
  pci_scan_root_bus() directly, bypassing the pci_common_init
  logic
- move PCI code into a separate file
- change PCI code into a driver by adding platform_device based
  probing
- add DT support for that driver.

For the PCIe code, the obvious strategy is to replace it with
the existing pcie-mvebu driver, adding any missing parts
in the process.

	Arnd
