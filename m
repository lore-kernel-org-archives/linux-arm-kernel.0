From: gores@marvell.com (Siddarth Gore)
Date: Wed, 5 May 2010 13:28:04 +0530
Subject: adding pxa3xx_nand_flash to platform data
Message-ID: <1273046285.29563.311.camel@pe-dt434>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Eric,

Currently I need to enable the deprecated MTD_NAND_PXA3xx_BUILTIN
support for Aspenite DB board (pxa168). I have a patch ready to add
pxa3xx_nand_flash in aspenite.c but I was wondering about the cmdset
field in it.
Looks like it is the same for all boards (depending upon the page size).
So should I add it to the board specific setup file or remove it from
pxa3xx_nand_platform_data (and put it in say, pxa3xx_nand_info)?

If there are boards which require a different cmdset then we have to go
with first option, if not, we can use option two and save some code
duplication.

-siddarth
