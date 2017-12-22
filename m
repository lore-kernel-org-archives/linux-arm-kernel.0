From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 22 Dec 2017 21:47:18 +0100
Subject: [PATCH v2 3/5] mtd: nand: replace pxa3xx_nand driver by its
 rework called marvell_nand
In-Reply-To: <20171219132942.27433-4-miquel.raynal@free-electrons.com> (Miquel
 Raynal's message of "Tue, 19 Dec 2017 14:29:40 +0100")
References: <20171219132942.27433-1-miquel.raynal@free-electrons.com>
 <20171219132942.27433-4-miquel.raynal@free-electrons.com>
Message-ID: <87608ycwx5.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Miquel Raynal <miquel.raynal@free-electrons.com> writes:

> Actually remove pxa3xx_nand.c to let marvell_nand.c be compiled instead.
> Also change the defconfig files using it as well as some board files
> depending on CONFIG_MTD_NAND_PXA3xx.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>

Actually that approach doesn't quite suit me.
I'm not convinced at all a new rewrite of the driver will be stable right out of
the box as the old one is.

What I would propose instead is :
 - keep both the new marvell nand driver and the old pxa3xx_nand driver
 - switch pxa_defconfig to compile them both
 - continue testing (with my help)

Once I see the marvell_nand is working properly, we can remove pca3xx_nand in a
second stage, keeping the pxa platform functional all along.

Would you agree to that path ?

As a side not, this patch should be split into 2 parts :
 - one for arch/arm -> switch to the new driver
 - one for drivers/mtd -> removal of the old driver

Cheers.

--
Robert
