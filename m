From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 1 Dec 2017 11:38:36 +0900
Subject: [PATCH 2/5] mtd: nand: provide several helpers to do common NAND
 operations
In-Reply-To: <20171130170132.27522-3-miquel.raynal@free-electrons.com>
References: <20171130170132.27522-1-miquel.raynal@free-electrons.com>
 <20171130170132.27522-3-miquel.raynal@free-electrons.com>
Message-ID: <CAK7LNAT+_vjtjuLmBGaLYbOnN=oZ99tUogWCPgvbsy53aiboxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-12-01 2:01 GMT+09:00 Miquel Raynal <miquel.raynal@free-electrons.com>:
> From: Boris Brezillon <boris.brezillon@free-electrons.com>
>
> This is part of the process of removing direct calls to ->cmdfunc()
> outside of the core in order to introduce a better interface to execute
> NAND operations.
>
> Here we provide several helpers and make use of them to remove all
> direct calls to ->cmdfunc(). This way, we can easily modify those
> helpers to make use of the new ->exec_op() interface when available.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> [miquel.raynal at free-electrons.com: rebased and fixed some conflicts]
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
> ---
>  drivers/mtd/nand/atmel/nand-controller.c |    2 +-
>  drivers/mtd/nand/brcmnand/brcmnand.c     |    9 +-
>  drivers/mtd/nand/cafe_nand.c             |   14 +-
>  drivers/mtd/nand/denali.c                |   37 +-

For denali.c

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


-- 
Best Regards
Masahiro Yamada
