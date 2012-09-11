From: linux@prisktech.co.nz (Tony Prisk)
Date: Tue, 11 Sep 2012 20:54:03 +0000
Subject: [PATCH 10/16] ARM: vt8500: move platform_data definitions
In-Reply-To: <1347368390-31252-10-git-send-email-arnd@arndb.de>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-10-git-send-email-arnd@arndb.de>
Message-ID: <1347397033.2141.4.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-09-11 at 14:59 +0200, Arnd Bergmann wrote:
> Platform data for device drivers should be defined in
> include/linux/platform_data/*.h, not in the architecture
> and platform specific directories.
> 
> This moves such data out of the vt8500 include directories
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Tony Prisk <linux@prisktech.co.nz>
> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> ---
>  arch/arm/mach-vt8500/devices.c                                       |    2 +-
>  drivers/video/vt8500lcdfb.c                                          |    2 +-
>  drivers/video/wm8505fb.c                                             |    2 +-
>  .../vt8500fb.h => include/linux/platform_data/video-vt8500lcdfb.h    |    0
>  4 files changed, 3 insertions(+), 3 deletions(-)
>  rename arch/arm/mach-vt8500/include/mach/vt8500fb.h => include/linux/platform_data/video-vt8500lcdfb.h (100%)
> 
> diff --git a/arch/arm/mach-vt8500/devices.c b/arch/arm/mach-vt8500/devices.c
> index 1fcdc36..82b4bce 100644
> --- a/arch/arm/mach-vt8500/devices.c
> +++ b/arch/arm/mach-vt8500/devices.c
> @@ -23,7 +23,7 @@
>  
>  #include <asm/mach/arch.h>
>  
> -#include <mach/vt8500fb.h>
> +#include <linux/platform_data/video-vt8500lcdfb.h>
>  #include <mach/i8042.h>
>  #include "devices.h"
>  
> diff --git a/drivers/video/vt8500lcdfb.c b/drivers/video/vt8500lcdfb.c
> index 2a5fe6e..66a74f9 100644
> --- a/drivers/video/vt8500lcdfb.c
> +++ b/drivers/video/vt8500lcdfb.c
> @@ -30,7 +30,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/wait.h>
>  
> -#include <mach/vt8500fb.h>
> +#include <linux/platform_data/video-vt8500lcdfb.h>
>  
>  #include "vt8500lcdfb.h"
>  #include "wmt_ge_rops.h"
> diff --git a/drivers/video/wm8505fb.c b/drivers/video/wm8505fb.c
> index c8703bd..ffeff48 100644
> --- a/drivers/video/wm8505fb.c
> +++ b/drivers/video/wm8505fb.c
> @@ -29,7 +29,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/wait.h>
>  
> -#include <mach/vt8500fb.h>
> +#include <linux/platform_data/video-vt8500lcdfb.h>
>  
>  #include "wm8505fb_regs.h"
>  #include "wmt_ge_rops.h"
> diff --git a/arch/arm/mach-vt8500/include/mach/vt8500fb.h b/include/linux/platform_data/video-vt8500lcdfb.h
> similarity index 100%
> rename from arch/arm/mach-vt8500/include/mach/vt8500fb.h
> rename to include/linux/platform_data/video-vt8500lcdfb.h

Acked-by: Tony Prisk <linux@prisktech.co.nz>

Be aware that my current patch series (which has now been finalized)
drops mach-vt8500/devices.c so you might get a conflict depending on the
patch order.
