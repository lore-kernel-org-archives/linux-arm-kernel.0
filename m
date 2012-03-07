From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Mar 2012 19:00:47 +0000
Subject: [PATCH 14/14] ARM: kirkwood: use devicetree to init sata_mv
In-Reply-To: <20120307185204.GD5050@titan.lakedaemon.net>
References: <cover.1331090356.git.jason@lakedaemon.net>
 <201203071840.09572.arnd@arndb.de>
 <20120307185204.GD5050@titan.lakedaemon.net>
Message-ID: <201203071900.48096.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 March 2012, Jason wrote:
> > Is it guaranteed that it's always the first port that gets used if there
> > is only one? If not, this might turn on the wrong one.
> 
> This is the same logic as mach-kirkwood/common.c:176
> 
> void __init kirkwood_sata_init(struct mv_sata_platform_data *sata_data)
> {
>         kirkwood_clk_ctrl |= CGC_SATA0;
>         if (sata_data->n_ports > 1)
>                 kirkwood_clk_ctrl |= CGC_SATA1;
> 
>         orion_sata_init(sata_data, SATA_PHYS_BASE, IRQ_KIRKWOOD_SATA);
> }
> 
> So, I don't think I'm introducing a regression.

Ok, good point. I was wondering whether the individual ports should
be modeled in the device tree, but I guess it's not necessary if nobody
needed this so far.

	Arnd
