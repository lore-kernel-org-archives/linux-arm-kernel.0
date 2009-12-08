From: leochen@broadcom.com (Leo (Hao) Chen)
Date: Tue, 8 Dec 2009 11:55:40 -0800
Subject: [PATCH] Bcmring: fix build error with bcmring_defconfig
In-Reply-To: <20091208023929.GP26191@broadcom.com>
References: <20091208023929.GP26191@broadcom.com>
Message-ID: <20091208195540.GA7383@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch shouldn't be needed. Not our problem.  It is fixed in

http://git.kernel.org/tip/2ff6cfd70720780234fdfea636218c2a62b31287

best,

Leo

On Mon, Dec 07, 2009 at 06:39:29PM -0800, Leo (Hao) Chen wrote:
> 
> Hi,
> 
> This patch is to fix the build error with bcmring_defconfig.
> 
> The error is caught by KAutoBuild.
> 
> /var/tmp/kernel-orig/usr/include/linux/perf_event.h:22: included file
> 'asm-arm/hw_breakpoint.h' is not exported
> make[3]: *** [/var/tmp/kernel-orig/usr/include/linux/.check] Error 123
> make[2]: *** [linux] Error 2
> make[1]: *** [headers_check] Error 2
> make: *** [vmlinux] Error 2
> make: Leaving directory `/var/tmp/kernel-orig'
> 
> From: Leo Chen <leochen@broadcom.com>
> Date: Mon, 7 Dec 2009 18:36:58 -0800
> Subject: [PATCH] disable header check to fix build error of bcmring_defconfig
> 
> 
> Signed-off-by: Leo Hao Chen <leochen@broadcom.com>
> ---
>  arch/arm/configs/bcmring_defconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/configs/bcmring_defconfig b/arch/arm/configs/bcmring_defconfig
> index bcc0bac..04b063b 100644
> --- a/arch/arm/configs/bcmring_defconfig
> +++ b/arch/arm/configs/bcmring_defconfig
> @@ -678,7 +678,7 @@ CONFIG_FRAME_WARN=1024
>  CONFIG_MAGIC_SYSRQ=y
>  # CONFIG_UNUSED_SYMBOLS is not set
>  # CONFIG_DEBUG_FS is not set
> -CONFIG_HEADERS_CHECK=y
> +# CONFIG_HEADERS_CHECK is not set
>  # CONFIG_DEBUG_KERNEL is not set
>  # CONFIG_DEBUG_BUGVERBOSE is not set
>  # CONFIG_DEBUG_MEMORY_INIT is not set
> -- 
> 1.6.0.6
> 
> -- 
> 
> Leo Hao Chen

-- 
