From: will.deacon@arm.com (Will Deacon)
Date: Fri, 6 Nov 2015 12:30:09 +0000
Subject: [PATCH] arm64: remove redundant FRAME_POINTER kconfig option
In-Reply-To: <1446658671-16238-1-git-send-email-yang.shi@linaro.org>
References: <1446658671-16238-1-git-send-email-yang.shi@linaro.org>
Message-ID: <20151106123008.GK6087@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 04, 2015 at 09:37:51AM -0800, Yang Shi wrote:
> FRAME_POINTER is defined in lib/Kconfig.debug, it is unnecessary to redefine
> it in arch/arm64/Kconfig.debug.

It might be worth noting that this adds a dependency on DEBUG_KERNEL
for building with frame pointers. I'm ok with that (it appears to be
enabled in defconfig and follows the vast majority of other archs) but
it is a change in behaviour.

With that:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will

> Signed-off-by: Yang Shi <yang.shi@linaro.org>
> ---
>  arch/arm64/Kconfig.debug | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
> index d6285ef..915dea7 100644
> --- a/arch/arm64/Kconfig.debug
> +++ b/arch/arm64/Kconfig.debug
> @@ -2,10 +2,6 @@ menu "Kernel hacking"
>  
>  source "lib/Kconfig.debug"
>  
> -config FRAME_POINTER
> -	bool
> -	default y
> -
>  config ARM64_PTDUMP
>  	bool "Export kernel pagetable layout to userspace via debugfs"
>  	depends on DEBUG_KERNEL
> -- 
> 2.0.2
> 
