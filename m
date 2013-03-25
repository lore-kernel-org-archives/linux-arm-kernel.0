From: robherring2@gmail.com (Rob Herring)
Date: Mon, 25 Mar 2013 10:07:48 -0500
Subject: [PATCH] ARM: l2x0: don't set .set_debug in l310 case
In-Reply-To: <1364149654-16163-1-git-send-email-p.pisati@gmail.com>
References: <1364149654-16163-1-git-send-email-p.pisati@gmail.com>
Message-ID: <51506844.3030108@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/24/2013 01:27 PM, Paolo Pisati wrote:
> From: Paolo Pisati <paolo.pisati@canonical.com>
> 
> commit 74ddcdb ("l2x0: Only set .set_debug on PL310 r3p0 and earlier")
> to actually work needs .set_debug to be not set during definition
> 
> Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
> ---
>  arch/arm/mm/cache-l2x0.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index d457653..37f1364 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -724,7 +724,6 @@ static const struct l2x0_of_data pl310_data = {
>  		.flush_all   = l2x0_flush_all,
>  		.inv_all     = l2x0_inv_all,
>  		.disable     = l2x0_disable,
> -		.set_debug   = pl310_set_debug,

This actually breaks the cases that need set_debug because the memcpy of
the function pointers is after the set_debug init. So I'll come up with
something else.

Rob
