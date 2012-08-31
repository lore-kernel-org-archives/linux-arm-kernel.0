From: gerg@snapgear.com (Greg Ungerer)
Date: Fri, 31 Aug 2012 16:30:01 +1000
Subject: [PATCH 3/4] ARM: ks8695: delete resume hook from timer
In-Reply-To: <1346264832-20379-1-git-send-email-linus.walleij@linaro.org>
References: <1346264832-20379-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <504059E9.9090606@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/30/2012 04:27 AM, Linus Walleij wrote:
> This system does not support suspend/resume so let's skip this
> hook altogether.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Tested-by: Greg Ungerer <gerg@snapgear.com>


> ---
>   arch/arm/mach-ks8695/time.c |    1 -
>   1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-ks8695/time.c b/arch/arm/mach-ks8695/time.c
> index ae9dacc..6974c23 100644
> --- a/arch/arm/mach-ks8695/time.c
> +++ b/arch/arm/mach-ks8695/time.c
> @@ -127,7 +127,6 @@ static void __init ks8695_timer_init (void)
>   struct sys_timer ks8695_timer = {
>   	.init		= ks8695_timer_init,
>   	.offset		= ks8695_gettimeoffset,
> -	.resume		= ks8695_timer_setup,
>   };
>
>   void ks8695_restart(char mode, const char *cmd)
>


-- 
------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg at snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close,                            FAX:         +61 7 3891 3630
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
