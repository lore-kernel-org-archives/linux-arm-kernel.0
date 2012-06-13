From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Jun 2012 20:21:08 +0000
Subject: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
In-Reply-To: <20120613075232.GA6139@avionic-0098.mockup.avionic-design.de>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
 <4FD84133.4060401@firmworks.com>
 <20120613075232.GA6139@avionic-0098.mockup.avionic-design.de>
Message-ID: <201206132021.09774.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 June 2012, Thierry Reding wrote:
>                 pci at 80000000 {
>                         reg = <0x80000000 0x00001000>;
>                         status = "disabled";
> 
>                         #address-cells = <3>;
>                         #size-cells = <2>;
> 
>                         ranges = <0x80400000 0x80400000 0x00008000   /* I/O */
>                                   0x90000000 0x90000000 0x08000000   /* non-prefetchable memory */
>                                   0xa0000000 0xa0000000 0x08000000>; /* prefetchable memory */
> 
>                         nvidia,ctrl-offset = <0x0>;
>                         nvidia,num-lanes = <2>;
>                 };
> 

I believe you will need an "interrupt-map" property here, to map the host
interrupts to the INTA-INTD lines of the attached devices.

I'm not sure whether we want to have a device_type="pciex" property here.
powerpc and sparc seem to use that information, to distinguish a pcie
bus from pci or cardbus.

	Arnd
