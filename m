From: ray.jui@broadcom.com (Ray Jui)
Date: Wed, 8 Jun 2016 09:40:08 -0700
Subject: [PATCH] ARM: bcm: fix missing include of kona_l2_cache.h
In-Reply-To: <1465403758-2173-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465403758-2173-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <03175266-48af-fe2c-6e36-cf977c658596@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

On 6/8/2016 9:35 AM, Ben Dooks wrote:
> Fix a warning of kona_l2_cache_init() not being declared by
> including the header file kona_l2_cache.h which defines it
> thus fixing:
>
> arch/arm/mach-bcm/kona_l2_cache.c:21:13: warning: symbol 'kona_l2_cache_init' was not declared. Should it be static?
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: bcm-kernel-feedback-list at broadcom.com
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  arch/arm/mach-bcm/kona_l2_cache.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-bcm/kona_l2_cache.c b/arch/arm/mach-bcm/kona_l2_cache.c
> index b319703..59ad863 100644
> --- a/arch/arm/mach-bcm/kona_l2_cache.c
> +++ b/arch/arm/mach-bcm/kona_l2_cache.c
> @@ -17,6 +17,7 @@
>  #include <asm/hardware/cache-l2x0.h>
>
>  #include "bcm_kona_smc.h"
> +#include "kona_l2_cache.h"
>
>  void __init kona_l2_cache_init(void)
>  {
>

Thanks for fixing all these.

Acked-by: Ray Jui <ray.jui@broadcom.com>
