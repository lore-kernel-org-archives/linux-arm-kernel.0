From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 7 Mar 2017 21:04:50 +0900
Subject: [PATCH v2 3/3] mtd: nand: Remove unused chip->write_page() hook
In-Reply-To: <1487593718-20752-4-git-send-email-boris.brezillon@free-electrons.com>
References: <1487593718-20752-1-git-send-email-boris.brezillon@free-electrons.com>
 <1487593718-20752-4-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <CAK7LNASNFJ6_LJBS7jyyJ3-Uv_ExTYAj+tkJTCYrpDz8_BXa3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

2017-02-20 21:28 GMT+09:00 Boris Brezillon <boris.brezillon@free-electrons.com>:
> The last/only user of the chip->write_page() hook (the Atmel NAND
> controller driver) has been reworked and is no longer specifying a custom
> ->write_page() implementation.
> Drop this hook before someone else start abusing it.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>


Just a minor comment.


/**
 * nand_write_page - [REPLACEABLE] write one page
 * @mtd: MTD device structure


Can you update the comment block for nand_write_page(), too?

  [REPLACEABLE]  ->  [INTERNAL]




-- 
Best Regards
Masahiro Yamada
