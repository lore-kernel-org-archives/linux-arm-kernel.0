From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 13 Jan 2016 15:11:07 -0700
Subject: [PATCH v2] null_blk: use sector_div instead of do_div
In-Reply-To: <11387794.RmibjdD6Rx@wuerfel>
References: <11387794.RmibjdD6Rx@wuerfel>
Message-ID: <5696CB7B.6040107@kernel.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13/2016 03:04 PM, Arnd Bergmann wrote:
> Dividing a sector_t number should be done using sector_div rather than do_div
> to optimize the 32-bit sector_t case, and with the latest do_div optimizations,
> we now get a compile-time warning for this:
>
> arch/arm/include/asm/div64.h:32:95: note: expected 'uint64_t * {aka long long unsigned int *}' but argument is of type 'sector_t * {aka long unsigned int *}'
> drivers/block/null_blk.c:521:81: warning: comparison of distinct pointer types lacks a cast
>
> This changes the newly added code to use sector_div. It is a simplified version
> of the original patch, as Linus Torvalds pointed out that we should not be using
> an expensive division function in the first place.
>
> This version was suggested by Matias Bjorling.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Matias Bjorling <m@bjorling.me>
> Fixes: b2b7e00148a2 ("null_blk: register as a LightNVM device")
> ---
> [resent to Jens' correct address, sorry about the duplicates]

Thanks Arnd, added.

-- 
Jens Axboe
