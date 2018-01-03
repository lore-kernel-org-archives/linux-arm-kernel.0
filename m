From: Vineet.Gupta1@synopsys.com (Vineet Gupta)
Date: Wed, 3 Jan 2018 08:51:07 -0800
Subject: [PATCH] arch: drop duplicate exports of abort()
In-Reply-To: <20180102103311.706364-1-arnd@arndb.de>
References: <20180102103311.706364-1-arnd@arndb.de>
Message-ID: <987b38f9-cc49-c011-26f8-8bb10397ce2b@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/2018 02:33 AM, Arnd Bergmann wrote:
> We now have exports in both architecture code in in common code,
> which causes a link failure when symbol versioning is eanbled, on
> four architectures:
>
> kernel/exit.o: In function `__crc_abort':
> exit.c:(*ABS*+0xc0e2ec8b): multiple definition of `__crc_abort'
>
> This removes the four architecture specific exports and only
> leaves the export next to the __weak symbol.
>
> Fixes: mmotm ("kernel/exit.c: export abort() to modules")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Andrew, can you apply this to -mm on top of the other patch?
> ---
>   arch/arc/kernel/traps.c       | 1 -
>   arch/arm/kernel/traps.c       | 1 -
>   arch/m32r/kernel/traps.c      | 1 -
>   arch/unicore32/kernel/traps.c | 1 -
>   4 files changed, 4 deletions(-)
>
> diff --git a/arch/arc/kernel/traps.c b/arch/arc/kernel/traps.c
> index 51a55b06cb2a..133a4dae41fe 100644
> --- a/arch/arc/kernel/traps.c
> +++ b/arch/arc/kernel/traps.c
> @@ -169,4 +169,3 @@ void abort(void)
>   {
>   	__asm__ __volatile__("trap_s  5\n");
>   }
> -EXPORT_SYMBOL(abort);

FWIW, this hunk did not yet hit mainline. I've removed it from my patch in 
for-curr and re-pushed !

Thx,
-Vineet
