From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Jun 2016 10:43:19 +0200
Subject: [RFC][PATCH] arm: ubsan: select ARCH_HAS_UBSAN_SANITIZE_ALL
In-Reply-To: <1466487545-22819-1-git-send-email-sw0312.kim@samsung.com>
References: <1466487545-22819-1-git-send-email-sw0312.kim@samsung.com>
Message-ID: <12441230.VuJWJP4oWR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, June 21, 2016 2:39:05 PM CEST Seung-Woo Kim wrote:
> To enable UBSAN on arm, this patch enables ARCH_HAS_UBSAN_SANITIZE_ALL
> from arm confiuration. Basic kernel booting is tested on arm kernel
> enabled CONFIG_UBSAN_SANITIZE_ALL from Exynos5422 based Odroid-XU3
> board.
> 
> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
> ---
> Because I tested only with specific soc board, so I am not sure the ubsan is
> fine for all other cases. So, I send this patch as a RFC.
> 

I've tried this out on my build test box in the past, but ran into
some problems. In particular I ended up disabling 
-fsanitize=signed-integer-overflow and -fsanitize=object-size
and later reverting the whole thing, but don't remember exactly
why (possibly I was hitting internal compiler errors?).'

Let me re-enable it with your patch locally and report back
with whatever build problems I run into.

	Arnd
