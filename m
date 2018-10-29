From: will.deacon@arm.com (Will Deacon)
Date: Mon, 29 Oct 2018 10:29:19 +0000
Subject: [PATCH v2 1/3] linkage.h: Align weak symbols.
In-Reply-To: <20180920135631.23833-1-aryabinin@virtuozzo.com>
References: <20180914152800.GB6236@arm.com>
 <20180920135631.23833-1-aryabinin@virtuozzo.com>
Message-ID: <20181029102919.GB14127@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2018 at 04:56:29PM +0300, Andrey Ryabinin wrote:
> Since WEAK() supposed to be used instead of ENTRY() to define weak
> symbols, but unlike ENTRY() it doesn't have ALIGN directive.
> It seems there is no actual reason to not have, so let's add
> ALIGN to WEAK() too.
> 
> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> ---
>  include/linux/linkage.h | 1 +
>  1 file changed, 1 insertion(+)

Looks sensible to me:

Acked-by: Will Deacon <will.deacon@arm.com>

Will

> diff --git a/include/linux/linkage.h b/include/linux/linkage.h
> index d7618c41f74c..7c47b1a471d4 100644
> --- a/include/linux/linkage.h
> +++ b/include/linux/linkage.h
> @@ -90,6 +90,7 @@
>  #ifndef WEAK
>  #define WEAK(name)	   \
>  	.weak name ASM_NL   \
> +	ALIGN ASM_NL \
>  	name:
>  #endif
>  
> -- 
> 2.16.4
> 
