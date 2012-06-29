From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 29 Jun 2012 08:57:47 +0800
Subject: [PATCH] ARM: mxs/tx28: fix odd include
In-Reply-To: <1340879945.1911.49.camel@x61.thuisdomein>
References: <1340879945.1911.49.camel@x61.thuisdomein>
Message-ID: <20120629005745.GC23422@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2012 at 12:39:05PM +0200, Paul Bolle wrote:
> arch/arm/mach-mxs/module-tx28.c includes "../devices-mx28.h". That's a
> bit odd, because that header can be found in the same directory. This
> only works because arch/arm/mach-mxs/include should be in the header
> search path for this file. Nevertheless, this file can simply include
> "device-mx28.h" (just as the four other files including that header do).
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>

Applied, thanks.

Regards,
Shawn

> ---
> 0) Untested, but obviously correct.
> 
>  arch/arm/mach-mxs/module-tx28.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/module-tx28.c b/arch/arm/mach-mxs/module-tx28.c
> index 9a7b08b..0f71f82 100644
> --- a/arch/arm/mach-mxs/module-tx28.c
> +++ b/arch/arm/mach-mxs/module-tx28.c
> @@ -11,7 +11,7 @@
>  #include <linux/gpio.h>
>  
>  #include <mach/iomux-mx28.h>
> -#include "../devices-mx28.h"
> +#include "devices-mx28.h"
>  
>  #include "module-tx28.h"
>  
> -- 
> 1.7.7.6
> 
