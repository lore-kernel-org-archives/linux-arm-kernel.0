From: olof@lixom.net (Olof Johansson)
Date: Sat, 29 Sep 2012 14:18:05 -0700
Subject: [PATCH] arm: vt8500: Fixup for missing gpio.h
In-Reply-To: <1348595239-30577-2-git-send-email-linux@prisktech.co.nz>
References: <1348595239-30577-1-git-send-email-linux@prisktech.co.nz>
 <1348595239-30577-2-git-send-email-linux@prisktech.co.nz>
Message-ID: <20120929211805.GF12999@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 26, 2012 at 05:47:19AM +1200, Tony Prisk wrote:
> mach/include/gpio.h was removed as part of the multiplatform-3.7
> update. This patch removes the include from arch-vt8500/vt8500.c
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
>  arch/arm/mach-vt8500/vt8500.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-vt8500/vt8500.c b/arch/arm/mach-vt8500/vt8500.c
> index 4494993..587ea95 100644
> --- a/arch/arm/mach-vt8500/vt8500.c
> +++ b/arch/arm/mach-vt8500/vt8500.c
> @@ -32,7 +32,6 @@
>  #include <linux/of_platform.h>
>  
>  #include <mach/restart.h>
> -#include <mach/gpio.h>
>  
>  #include "common.h"

Applied on top of existing vt8500/devel branch, thanks.

By the way, I noticed that there is no VT8500 defconfig in the tree, so there's
no easy way for us to check for build breakages of your platform. You might
want to add one.

Also, I noticed the following build warnings that you might want to address
when I just built a very trivial config that enables the platform:

arch/arm/mach-vt8500/vt8500.c: In function 'vt8500_init':
arch/arm/mach-vt8500/vt8500.c:81:8: warning: unused variable 'gpio_base' [-Wunused-variable]
arch/arm/mach-vt8500/vt8500.c:80:27: warning: unused variable 'fb' [-Wunused-variable]


-Olof
