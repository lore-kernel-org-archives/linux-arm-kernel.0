From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 26 Jun 2013 16:33:54 +0400
Subject: [PATCH 3/4] ARM: shmobile: r8a7790: don't use external clock
 for SCIFs
In-Reply-To: <1372236787-23342-4-git-send-email-horms+renesas@verge.net.au>
References: <1372236787-23342-1-git-send-email-horms+renesas@verge.net.au>
 <1372236787-23342-4-git-send-email-horms+renesas@verge.net.au>
Message-ID: <51CADFB2.8040800@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 26-06-2013 12:53, Simon Horman wrote:

> From: Ulrich Hecht <ulrich.hecht@gmail.com>

> This is an external component and may or may not be there, while the
> internal clock always works.

> Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   arch/arm/mach-shmobile/setup-r8a7790.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
> index 896d374..6531f3d 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7790.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7790.c
> @@ -64,7 +64,7 @@ void __init r8a7790_pinmux_init(void)
>   [index] = {						\
>   	SCIF_COMMON(PORT_SCIF, baseaddr, irq),		\
>   	.scbrr_algo_id	= SCBRR_ALGO_2,			\
> -	.scscr = SCSCR_RE | SCSCR_TE | SCSCR_CKE1,	\
> +	.scscr = SCSCR_RE | SCSCR_TE,	\

    Backslash should have been aligned with the others above...

WBR, Sergei
