From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Thu, 19 Jul 2018 08:15:08 +0200
Subject: [RFC PATCH 0/8] mtd: rawnand: ams-delta: Use gpio-omap
 accessors for data I/O
In-Reply-To: <20180718235710.18242-1-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
Message-ID: <20180719081508.5dafebde@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Janusz,

On Thu, 19 Jul 2018 01:57:02 +0200
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Implement the idea suggested by Artem Bityutskiy and Tony Lindgren
> described in commit b027274d2e3a ("mtd: ams-delta: fix
> request_mem_region() failure").

Thanks for doing that. I'll review the patches, but I already have a
extra request: can you convert this driver to ->exec_op()? It does not
necessarily have to be done in this patchset, but, that'd be great to
have one more driver converted to the new interface.

BTW, there seems to be a nand_gpio driver, maybe we should merge
ams-delta code into nand_gpio after it's been patched to use the GPIO
consumer API.

> 
>  arch/arm/mach-omap1/board-ams-delta.c |   22 -
>  drivers/gpio/gpio-omap.c              |   88 ++++++
>  drivers/mtd/nand/raw/ams-delta.c      |  436 +++++++++++++++++++++-------------
>  3 files changed, 376 insertions(+), 170 deletions(-)
> 
