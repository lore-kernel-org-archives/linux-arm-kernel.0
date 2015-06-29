From: rjui@broadcom.com (Ray Jui)
Date: Mon, 29 Jun 2015 09:38:02 -0700
Subject: [PATCH] ARM: BCM: Enable NAND support for iProc SoCs
In-Reply-To: <558DBC53.3050100@gmail.com>
References: <1432861754-26606-1-git-send-email-rjui@broadcom.com>
 <558DBC53.3050100@gmail.com>
Message-ID: <5591746A.80300@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

On 6/26/2015 1:55 PM, Florian Fainelli wrote:
> On 28/05/15 18:09, Ray Jui wrote:
>> Select CONFIG_MTD_NAND_BRCMNAND for all iProc SoCs
> 
> In fact, this patch creates an unmet dependency problem, we also need to
> select MTD and MTD_NAND otherwise we run into a linking error while
> building the brcmnand driver:
> 
>   LD      init/built-in.o
> drivers/built-in.o: In function `brcmnand_remove':
> /home/fainelli/dev/linux/drivers/mtd/nand/brcmnand/brcmnand.c:2234:
> undefined reference to `nand_release'
> drivers/built-in.o: In function `brcmnand_init_cs':
> /home/fainelli/dev/linux/drivers/mtd/nand/brcmnand/brcmnand.c:1933:
> undefined reference to `nand_scan_ident'
> /home/fainelli/dev/linux/drivers/mtd/nand/brcmnand/brcmnand.c:1958:
> undefined reference to `nand_scan_tail'
> Makefile:931: recipe for target 'vmlinux' failed
> make: *** [vmlinux] Error 1
> 
> I will take care of that and send a fix for 4.2.
> 

When I tested this, I tested against multi_v7_defconfig where MTD and
MTD_NAND were enabled in the defconfig, so I did not see this problem.

Thanks a lot for helping to fix this.

Ray
