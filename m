From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 2 Mar 2017 14:12:52 +0000
Subject: [PATCHv2 14/14] treewide: Decouple cacheflush.h and set_memory.h
In-Reply-To: <1488413706-9739-15-git-send-email-labbott@redhat.com>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
 <1488413706-9739-15-git-send-email-labbott@redhat.com>
Message-ID: <20170302141251.GM19632@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 01, 2017 at 04:15:06PM -0800, Laura Abbott wrote:
> 
> Now that all call sites, completely decouple cacheflush.h and
> set_memory.h
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>  arch/arm/include/asm/cacheflush.h   | 1 -
>  arch/arm64/include/asm/cacheflush.h | 1 -
>  arch/s390/include/asm/Kbuild        | 1 +
>  arch/s390/include/asm/cacheflush.h  | 8 --------
>  arch/x86/include/asm/cacheflush.h   | 1 -
>  5 files changed, 1 insertion(+), 11 deletions(-)
>  delete mode 100644 arch/s390/include/asm/cacheflush.h
> 
> diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
> index 1cb9d11..d69bebf 100644
> --- a/arch/arm/include/asm/cacheflush.h
> +++ b/arch/arm/include/asm/cacheflush.h
> @@ -16,7 +16,6 @@
>  #include <asm/shmparam.h>
>  #include <asm/cachetype.h>
>  #include <asm/outercache.h>
> -#include <asm/set_memory.h>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
