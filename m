From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 7 Sep 2012 11:08:45 -0400
Subject: [PATCH 04/12] ARM: mvebu: move debug macros to include/debug
In-Reply-To: <1346962375-26163-5-git-send-email-robherring2@gmail.com>
References: <1346962375-26163-1-git-send-email-robherring2@gmail.com>
 <1346962375-26163-5-git-send-email-robherring2@gmail.com>
Message-ID: <20120907150845.GE19437@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2012 at 03:12:47PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Move mvebu debug-macro.S over to common debug macro directory.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>

As with the other patch involving -mvebu, please include Gregory Clement
in the Cc:  I've added him to bring this patch to his attention.

thx,

Jason.

> ---
>  arch/arm/Kconfig.debug                             |    8 ++++++++
>  .../mach/debug-macro.S => include/debug/mvebu.S}   |    3 ++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>  rename arch/arm/{mach-mvebu/include/mach/debug-macro.S => include/debug/mvebu.S} (86%)
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 525d9bd..3bafdd2 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -261,6 +261,13 @@ choice
>  		  Say Y here if you want the debug print routines to direct
>  		  their output to the serial port on MSM 8960 devices.
>  
> +	config DEBUG_MVEBU_UART
> +		bool "Kernel low-level debugging messages via MVEBU UART"
> +		depends on ARCH_MVEBU
> +		help
> +		  Say Y here if you want kernel low-level debugging support
> +		  on MVEBU based platforms.
> +
>  	config DEBUG_REALVIEW_STD_PORT
>  		bool "RealView Default UART"
>  		depends on ARCH_REALVIEW
> @@ -377,6 +384,7 @@ config DEBUG_LL_INCLUDE
>  	string
>  	default "debug/icedcc.S" if DEBUG_ICEDCC
>  	default "debug/highbank.S" if DEBUG_HIGHBANK_UART
> +	default "debug/mvebu.S" if DEBUG_MVEBU_UART
>  	default "debug/vexpress.S" if DEBUG_VEXPRESS_UART0_DETECT || \
>  		DEBUG_VEXPRESS_UART0_CA9 || DEBUG_VEXPRESS_UART0_RS1
>  	default "mach/debug-macro.S"
> diff --git a/arch/arm/mach-mvebu/include/mach/debug-macro.S b/arch/arm/include/debug/mvebu.S
> similarity index 86%
> rename from arch/arm/mach-mvebu/include/mach/debug-macro.S
> rename to arch/arm/include/debug/mvebu.S
> index 2282576..865c6d0 100644
> --- a/arch/arm/mach-mvebu/include/mach/debug-macro.S
> +++ b/arch/arm/include/debug/mvebu.S
> @@ -11,7 +11,8 @@
>   * published by the Free Software Foundation.
>  */
>  
> -#include <mach/armada-370-xp.h>
> +#define ARMADA_370_XP_REGS_PHYS_BASE	0xd0000000
> +#define ARMADA_370_XP_REGS_VIRT_BASE	0xfeb00000
>  
>  	.macro	addruart, rp, rv, tmp
>  	ldr	\rp, =ARMADA_370_XP_REGS_PHYS_BASE
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
