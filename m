From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 9 May 2013 11:39:40 +0100
Subject: [PATCH 14/21] arm64: delay: remove inline marking of
 EXPORT_SYMBOL functions
In-Reply-To: <1368095819-11011-3-git-send-email-yefremov.denis@gmail.com>
References: <1368086241-9357-1-git-send-email-yefremov.denis@gmail.com>
 <1368095819-11011-3-git-send-email-yefremov.denis@gmail.com>
Message-ID: <20130509103939.GD668@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 09, 2013 at 11:36:52AM +0100, Denis Efremov wrote:
> EXPORT_SYMBOL and inline directives are contradictory to each other.
> The patch fixes this inconsistency.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Denis Efremov <yefremov.denis@gmail.com>
> ---
>  arch/arm64/lib/delay.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/lib/delay.c b/arch/arm64/lib/delay.c
> index dad4ec9..368ca15 100644
> --- a/arch/arm64/lib/delay.c
> +++ b/arch/arm64/lib/delay.c
> @@ -33,7 +33,7 @@ void __delay(unsigned long cycles)
>  }
>  EXPORT_SYMBOL(__delay);
>  
> -inline void __const_udelay(unsigned long xloops)
> +void __const_udelay(unsigned long xloops)
>  {
>  	unsigned long loops;

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
