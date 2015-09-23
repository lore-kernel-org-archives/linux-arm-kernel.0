From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Sep 2015 09:51:30 +0200
Subject: [PATCH v2] PCI: generic: Add support for Cavium ThunderX PCIe
 root complexes.
In-Reply-To: <1442967415-13595-1-git-send-email-ddaney.cavm@gmail.com>
References: <1442967415-13595-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <1524364.fcqUh1gtkt@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 September 2015 17:16:55 David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> The config space for external PCIe root complexes on some Cavium
> ThunderX SoCs is very similar to CAM and ECAM, but differs in the
> shift values that have to be applied to the bus and devfn numbers to
> compose that address window offset.  These root complexes also have
> the interesting property that there is no root bridge, so the standard
> manner of limiting scanning to only the first device doesn't work.  We
> can use the standard pci-host-generic driver if we make a minor
> addition to handle these differences, so we...
> 
> Add a mapping function for ThunderX PCIe root complexes with a bus
> shift of 24 and devfn shift of 16.  Ignore accesses for devices other
> than the first device on the primary bus.
> 
> Document the whole thing in devicetree/bindings/pci/host-generic-pci.txt
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
