From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 13 Sep 2009 23:28:47 +0200
Subject: [PATCH] arm: remove unused code in delay.S
In-Reply-To: <1252875960-21512-1-git-send-email-felipe.contreras@gmail.com>
References: <1252875960-21512-1-git-send-email-felipe.contreras@gmail.com>
Message-ID: <200909132328.47079.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Ne 13. z??? 2009 23:05:59 Felipe Contreras napsal(a):
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  arch/arm/lib/delay.S |   16 ----------------
>  1 files changed, 0 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/lib/delay.S b/arch/arm/lib/delay.S
> index 8d6a876..b741eb4 100644
> --- a/arch/arm/lib/delay.S
> +++ b/arch/arm/lib/delay.S
> @@ -42,22 +42,6 @@ ENTRY(__const_udelay)				@ 0 <= r0 <= 0x7fffff06
>  @ Delay routine
>  ENTRY(__delay)
>  		subs	r0, r0, #1
> -#if 0
> -		movls	pc, lr
> -		subs	r0, r0, #1
> -		movls	pc, lr
> -		subs	r0, r0, #1
> -		movls	pc, lr
> -		subs	r0, r0, #1
> -		movls	pc, lr
> -		subs	r0, r0, #1
> -		movls	pc, lr
> -		subs	r0, r0, #1
> -		movls	pc, lr
> -		subs	r0, r0, #1
> -		movls	pc, lr
> -		subs	r0, r0, #1
> -#endif
>  		bhi	__delay
>  		mov	pc, lr
>  ENDPROC(__udelay)
> 
Hi

why was this code there in the first place ?
