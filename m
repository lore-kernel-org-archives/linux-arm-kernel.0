From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 25 Jan 2013 10:29:42 -0800
Subject: [PATCH v2] ARM: plat-samsung: using vsnprintf instead of vsprintf
 for the limit buffer length 256
In-Reply-To: <50FE0D8B.7010908@asianux.com>
References: <50FE0D8B.7010908@asianux.com>
Message-ID: <013d01cdfb29$f3595000$da0bf000$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chen Gang wrote:
> 
> 
>   the buff is 256 limited, so need use vsnprintf instead of vsprintf
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> Cc: Ben Dooks <ben@fluff.org>
> ---
>  arch/arm/plat-samsung/pm.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/plat-samsung/pm.c b/arch/arm/plat-samsung/pm.c
> index 1507028..d896add 100644
> --- a/arch/arm/plat-samsung/pm.c
> +++ b/arch/arm/plat-samsung/pm.c
> @@ -51,7 +51,7 @@ void s3c_pm_dbg(const char *fmt, ...)
>  	char buff[256];
> 
>  	va_start(va, fmt);
> -	vsprintf(buff, fmt, va);
> +	vsnprintf(buff, sizeof(buff), fmt, va);
>  	va_end(va);
> 
>  	printascii(buff);
> --
> 1.7.10.4

Applied, thanks.

- Kukjin
