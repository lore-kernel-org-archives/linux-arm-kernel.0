From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 13 Feb 2012 16:14:06 -0600
Subject: [PATCH 02/15] ARM: add explicit include of system.h to processor.h
In-Reply-To: <1329169408-17253-3-git-send-email-robherring2@gmail.com>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <1329169408-17253-3-git-send-email-robherring2@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F41FCB4EB2@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, February 13, 2012 2:43 PM, Rob Herring wrote:
>
> cpu_relax in processor.h needs smp_mb which is defined in system.h.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
>  arch/arm/include/asm/processor.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
> index ce280b8..cb8d638 100644
> --- a/arch/arm/include/asm/processor.h
> +++ b/arch/arm/include/asm/processor.h
> @@ -22,6 +22,7 @@
>  #include <asm/hw_breakpoint.h>
>  #include <asm/ptrace.h>
>  #include <asm/types.h>
> +#include <asm/system.h>
>  
>  #ifdef __KERNEL__
>  #define STACK_TOP	((current->personality & ADDR_LIMIT_32BIT) ? \

On EP93xx

Tested-by: H Hartley Sweeten <hsweeten@visionengravers.com>
