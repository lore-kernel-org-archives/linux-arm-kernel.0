From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sun, 08 Nov 2009 22:07:41 +0100
Subject: IXP4xx repetitive 16-bit/32-bit I/O macros/inlines.
In-Reply-To: <4AF72907.1060705@hiramoto.org> (Karl Hiramoto's message of "Sun,
	08 Nov 2009 21:24:39 +0100")
References: <m3iqdkc0n6.fsf@intrepid.localdomain>
	<4AF72907.1060705@hiramoto.org>
Message-ID: <m3pr7safoi.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Karl Hiramoto <karl@hiramoto.org> writes:

>> Anybody using 32-bit PATA/SATA transfers on IXP4xx? :-)

> Yes, on  HPT371 IDE chip on the PCI  bus to interface to compact flash
> to store logs.

$ grep inherits drivers/ata/pata_hpt37x.c
        .inherits       = &ata_bmdma_port_ops,
        .inherits       = &hpt370_port_ops,
        .inherits       = &ata_bmdma_port_ops,
        .inherits       = &hpt372_port_ops,

Looks like 16-bit port_ops.

> For what it's worth I've only ever been able to make
> PIO work, I've never had any luck with the IDE DMA modes.  It hasn't
> been a high enough priority to investigate further.

Interesting. I have no issues with DMA modes, with VIA VT6421A (this
chip seems to have other critical problems), with CS5536 (PATA) and with
SIL3512 (the patch has to be applied in big-endian mode, and another
patch to sata_sil.c must be applied because IXP4xx can't do 8/16-bit
PCI MMIO read).
-- 
Krzysztof Halasa
