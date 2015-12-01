From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 1 Dec 2015 10:28:21 +0100
Subject: [PATCH v3 07/10] arm64: kernel: Include _AC definition in page.h
In-Reply-To: <1448559168-8363-8-git-send-email-james.morse@arm.com>
References: <1448559168-8363-1-git-send-email-james.morse@arm.com>
 <1448559168-8363-8-git-send-email-james.morse@arm.com>
Message-ID: <20151201092821.GB21222@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2015-11-26 17:32:45, James Morse wrote:
> page.h uses '_AC' in the definition of PAGE_SIZE, but doesn't include
> linux/const.h where this is defined. This produces build warnings when only
> asm/page.h is included by asm code.
> 
> Signed-off-by: James Morse <james.morse@arm.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

> ---
>  arch/arm64/include/asm/page.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
> index 9b2f5a9d019d..fbafd0ad16df 100644
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

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
