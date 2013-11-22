From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 22 Nov 2013 17:40:25 +0400
Subject: [PATCH] ARM: shmobile: lager: Constify lager_boards_compat_dt
In-Reply-To: <1385082175-30521-1-git-send-email-horms+renesas@verge.net.au>
References: <1385082175-30521-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <528F5EC9.9000203@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 22-11-2013 5:02, Simon Horman wrote:

> lager_boards_compat_dt is kmemdup()ed when the corresponding devices are
> registered and can thus be declared as const.  Do so.

> This replicates a portion of 27113d63daac0aac ("ARM: shmobile: lager:
> Constify platform data and resources") which appears to have inadvertently
> been lost during merging.

> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   arch/arm/mach-shmobile/board-lager.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
> index d47052e..04c5ca8 100644
> --- a/arch/arm/mach-shmobile/board-lager.c
> +++ b/arch/arm/mach-shmobile/board-lager.c
> @@ -249,7 +249,7 @@ static void __init lager_init(void)
>   	phy_register_fixup_for_id("r8a7790-ether-ff:01", lager_ksz8041_fixup);
>   }
>
> -static const char * const lager_boards_compat_dt[] __initconst = {
> +static const char *lager_boards_compat_dt[] __initdata = {
>   	"renesas,lager",
>   	NULL,

    But aren't you in fact reverting the described change?

WBR, Sergei
