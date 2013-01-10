From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 09 Jan 2013 16:44:26 -0800
Subject: [PATCH] ARM: s3c64xx: cpuidle: Fix missing header error with
 CONFIG_CPU_IDLE enabled
In-Reply-To: <1357778378-5278-1-git-send-email-tomasz.figa@gmail.com>
References: <1357778378-5278-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <00b801cdeecb$a5839c10$f08ad430$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> Recently the regs-syscon-power.h header was moved from
> mach-s3c64xx/include/mach to mach-s3c64xx/, but cpuidle.c was not
> updated to include the header from its new location, which caused
> build error with CONFIG_CPU_IDLE enabled.
> 
> This patch fixed the problem by updating the include line with
> proper header location.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  arch/arm/mach-s3c64xx/cpuidle.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/cpuidle.c b/arch/arm/mach-
> s3c64xx/cpuidle.c
> index e3e455b..50c66fe 100644
> --- a/arch/arm/mach-s3c64xx/cpuidle.c
> +++ b/arch/arm/mach-s3c64xx/cpuidle.c
> @@ -20,8 +20,7 @@
> 
>  #include <mach/map.h>
> 
> -#include <mach/regs-syscon-power.h>
> -
> +#include "regs-syscon-power.h"
>  #include "regs-sys.h"
> 
>  static int s3c64xx_enter_idle(struct cpuidle_device *dev,
> --
> 1.8.1

Oops, yes right. Thanks for your fix :-)

Will apply. 

- Kukjin
