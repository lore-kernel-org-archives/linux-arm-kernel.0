From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Sat, 21 Nov 2015 04:18:11 +0200
Subject: [PATCH] IB/iser: use sector_div instead of do_div
In-Reply-To: <5922990.8IJpyksX8K@wuerfel>
References: <5922990.8IJpyksX8K@wuerfel>
Message-ID: <564FD463.2020205@dev.mellanox.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> do_div is the wrong way to divide a sector_t, as it is less
> efficient when sector_t is 32-bit wide. With the upcoming
> do_div optimizations, the kernel starts warning about this:
>
> drivers/infiniband/ulp/iser/iser_verbs.c:1296:4: note: in expansion of macro 'do_div'
> include/asm-generic/div64.h:224:22: warning: passing argument 1 of '__div64_32' from incompatible pointer type
>
> This changes the code to use sector_div instead, which always
> produces optimal code.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd,

Reviewed-by: Sagi Grimberg <sagig@mellanox.com>
