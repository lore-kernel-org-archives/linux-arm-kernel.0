From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Apr 2016 15:06:59 +0200
Subject: [PATCH V6 08/13] PCI: generic,
 thunder: update to use generic ECAM API
In-Reply-To: <5715362A.7070701@semihalf.com>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <10639671.xGDtp1R8bk@wuerfel> <5715362A.7070701@semihalf.com>
Message-ID: <3830999.dF71UWYsBP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 April 2016 21:31:54 Tomasz Nowicki wrote:
> 
> Basically the whole content of pci-thunder-ecam.c and pci-thunder-pem.c.
> 
> pci-thunder-ecam.c contains config space accessors. Similar for 
> pci-thunder-pem.c but it also has extra init call (it is now called 
> thunder_pem_init) which finds and maps related registers.

They seem to do much more than just override the accessors, they actually
change the contents of the config space as well. Is that really necessary
on ACPI based systems as well?

Another idea: how about moving all of this logic into ACPI and calling
some AML method to access the config space if the devices are that
far out of spec.

	Arnd
