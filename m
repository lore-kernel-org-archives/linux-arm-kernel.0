From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 2 Apr 2012 10:24:05 +0000
Subject: [PATCH 1/3] PATA host controller driver for ep93xx
In-Reply-To: <4F797144.400@metasoft.pl>
References: <4F7418E7.4060500@metasoft.pl> <201204020808.34529.arnd@arndb.de>
 <4F797144.400@metasoft.pl>
Message-ID: <201204021024.05497.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 April 2012, Rafal Prylowski wrote:
> I think that inheriting from .ata_bmdma_port_ops is quite reasonable.
> Another option would be to inherit from .ata_sff_port_ops and implement
> .qc_issue hook (like in pata_octeon_cf.c), but this way we end up
> reimplementing the same things from libata-sff.c, IMHO. Also, I think
> that it's not possible to write PATA driver without this SFF stuff
> (at least for me - I'm not libata expert).
> I reviewed code paths from all hooks used in ep93xx driver to make sure
> that we use only ep93xx_pata_read/ep93xx_pata_write instead of ioread/iowrite.
> 
Ok, thanks for the confirmation.

	Arnd
