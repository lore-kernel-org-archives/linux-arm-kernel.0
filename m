From: will.deacon@arm.com (Will Deacon)
Date: Fri, 13 Dec 2013 16:45:18 +0000
Subject: [PATCH 5/5] arm64: Add LOAD_OFFSET symbol for linker scripts
In-Reply-To: <92660d1b81279aa6784a33eff2f102e78d883931.1386879684.git.geoff@infradead.org>
References: <cover.1386879684.git.geoff@infradead.org>
 <92660d1b81279aa6784a33eff2f102e78d883931.1386879684.git.geoff@infradead.org>
Message-ID: <20131213164517.GM19177@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 08:39:46PM +0000, Geoff Levand wrote:
> Add a definition for the LOAD_OFFSET symbol used in the linker
> scripts.  LOAD_OFFSET is used to generate the load address of
> the section.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org> for Huawei, Linaro

This isn't a standard SoB line. Please choose an email address and lose the
non-standard suffix.

> ---
>  arch/arm64/include/asm/memory.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 3776217..1994c56 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -52,6 +52,8 @@
>  #define EARLYCON_IOBASE		(MODULES_VADDR - SZ_4M)
>  #define TASK_SIZE_64		(UL(1) << VA_BITS)
>  
> +#define LOAD_OFFSET		(PAGE_OFFSET)

Can you be more specific about why we need this please? We don't seem to use
this on ARM, and I can't really think of a sensible value to define it as,
either. PAGE_OFFSET is a virtual address, which doesn't make much sense to
me, but perhaps I'm missing something.

Will
