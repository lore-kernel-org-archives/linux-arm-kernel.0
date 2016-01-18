From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 18 Jan 2016 10:05:20 +0000
Subject: [PATCH 02/19] arm64: kernel: Include _AC definition in page.h
In-Reply-To: <fa452028ae7cc140aa75bb10a6dd975bbe236281.1452884156.git.geoff@infradead.org>
References: <cover.1452884156.git.geoff@infradead.org>
 <fa452028ae7cc140aa75bb10a6dd975bbe236281.1452884156.git.geoff@infradead.org>
Message-ID: <20160118100519.GA21067@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 15, 2016 at 07:18:37PM +0000, Geoff Levand wrote:
> From: James Morse <james.morse@arm.com>
> 
> From: James Morse <james.morse@arm.com>

Not sure why this appears multiple times.

> page.h uses '_AC' in the definition of PAGE_SIZE, but doesn't include
> linux/const.h where this is defined. This produces build warnings when only
> asm/page.h is included by asm code.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Geoff Levand <geoff@infradead.org>

This is sensible even in isolation, so FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

I note that for the !__ASSEMBLY__ portion we use current,
READ_IMPLIES_EXEC, and some VM_* flags, without including the headers
those are defined in. It might be worth fixing those up also.

Mark.

> ---
>  arch/arm64/include/asm/page.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
> index 9b2f5a9..fbafd0a 100644
> --- a/arch/arm64/include/asm/page.h
> +++ b/arch/arm64/include/asm/page.h
> @@ -19,6 +19,8 @@
>  #ifndef __ASM_PAGE_H
>  #define __ASM_PAGE_H
>  
> +#include <linux/const.h>
> +
>  /* PAGE_SHIFT determines the page size */
>  /* CONT_SHIFT determines the number of pages which can be tracked together  */
>  #ifdef CONFIG_ARM64_64K_PAGES
> -- 
> 2.5.0
> 
> 
