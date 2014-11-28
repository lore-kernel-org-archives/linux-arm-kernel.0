From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 28 Nov 2014 02:15:41 -0500 (EST)
Subject: [PATCH] ARM: decompressor: fix a wrong comment
In-Reply-To: <1417155134-29808-1-git-send-email-yamada.m@jp.panasonic.com>
References: <1417155134-29808-1-git-send-email-yamada.m@jp.panasonic.com>
Message-ID: <alpine.LFD.2.11.1411280215050.11690@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 Nov 2014, Masahiro Yamada wrote:

> This comment does not correspond to the actual code.
> 
> When zImage is loaded at a lower *OR* higher address of
> the destination of Image, it won't overwrite itself.
> 
> Signed-off-by: Masahiro Yamada <yamada.m@jp.panasonic.com>

Acked-by: Nicolas Pitre <nico@linaro.org>


> ---
> 
>  arch/arm/boot/compressed/head.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 68be901..9dff614 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -178,7 +178,7 @@ not_angel:
>  
>  		/*
>  		 * Set up a page table only if it won't overwrite ourself.
> -		 * That means r4 < pc && r4 - 16k page directory > &_end.
> +		 * That means r4 < pc || r4 - 16k page directory > &_end.
>  		 * Given that r4 > &_end is most unfrequent, we add a rough
>  		 * additional 1MB of room for a possible appended DTB.
>  		 */
> -- 
> 1.9.1
> 
> 
