From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed, 29 Jun 2011 12:00:32 +0300
Subject: [PATCH V3 0/9] pxa3xx_nand: add two chip select support
In-Reply-To: <1309319494-17951-1-git-send-email-leiwen@marvell.com>
References: <1309246361.23597.30.camel@sauron>
	<1309319494-17951-1-git-send-email-leiwen@marvell.com>
Message-ID: <4E0AE9B0.7000908@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lei,

On 06/29/11 06:51, Lei Wen wrote:

> V2:
> Choose to at most keep original pxa3xx_nand_info structure to reduce
> patch size
>
> V3:
> Seperate original one patch into a patch set
>
> Lei Wen (9):
>   MTD: pxa3xx_nand: convert all printk into dev_*
>   MTD: pxa3xx_nand: enable multiple chip select support
>   ARM: aspenite: fix nand platform data
>   ARM: cm-x300: fix nand platform data
>   ARM: colibri-pxa3xx: fix nand platform data
>   ARM: littleton: fix nand platform data
>   ARM: mxm8x10: fix nand platform data
>   ARM: raumfeld: fix nand platform data
>   ARM: zylonite: fix nand platform data

While I agree with Artem, that reviewing patch sets are much more easier,
than a one single big patch, I think you should keep the
"fix nand platform data" changes all in one patch.
All of them do the same change, but for different boards.

>  arch/arm/mach-mmp/aspenite.c                 |    5 +-
>  arch/arm/mach-pxa/cm-x300.c                  |    5 +-
>  arch/arm/mach-pxa/colibri-pxa3xx.c           |    5 +-
>  arch/arm/mach-pxa/littleton.c                |    5 +-
>  arch/arm/mach-pxa/mxm8x10.c                  |    9 +-
>  arch/arm/mach-pxa/raumfeld.c                 |    5 +-
>  arch/arm/mach-pxa/zylonite.c                 |    5 +-
>  arch/arm/plat-pxa/include/plat/pxa3xx_nand.h |   19 +-
>  drivers/mtd/nand/pxa3xx_nand.c               |  512 +++++++++++++++-----------
>  9 files changed, 346 insertions(+), 224 deletions(-)
>
>

-- 
Regards,
Igor.
