From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Fri, 25 Feb 2011 12:39:31 +0200
Subject: [PATCH V4 0/6] pxa3xx_nand update series set version 4
In-Reply-To: <1298019428-7809-1-git-send-email-leiwen@marvell.com>
References: <1298019428-7809-1-git-send-email-leiwen@marvell.com>
Message-ID: <1298630371.2798.43.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-02-18 at 16:57 +0800, Lei Wen wrote:
> Change from previous version:
> rework the patch set accroding to Eric's suggestion.
> Move the recode judgement to the after command execution.
> 
> Lei Wen (6):
>   pxa3xx_nand: make scan procedure more clear
>   pxa3xx_nand: rework irq logic
>   pxa3xx_nand: discard wait_for_event,write_cmd,__readid function
>   pxa3xx_nand: unify prepare command
>   pxa3xx_nand: mtd scan id process could be defined by driver itself
>   pxa3xx_nand: clean the keep configure code

Hi, could you please make checkpatch.pl happy and re-send the patches?

There are many issues. OK, some are fine, do not try to fix them, e.g.:

WARNING: line over 80 characters
#127: FILE: drivers/mtd/nand/pxa3xx_nand.c:221:
+{ "512MiB 16-bit", 0xcc2c,  64, 2048, 16, 16, 4096, &default_cmdset, &timing[2] },

but some are clearly stylistic errors:

ERROR: else should follow close brace '}'
#249: FILE: drivers/mtd/nand/pxa3xx_nand.c:539:
+                }
+                else {

etc.

Thanks!

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
