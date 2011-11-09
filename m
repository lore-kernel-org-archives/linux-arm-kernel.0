From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 9 Nov 2011 08:45:03 +0000
Subject: [PATCH] ARM: arch.h: Include irq.h
In-Reply-To: <1320811364-12122-1-git-send-email-festevam@gmail.com>
References: <1320811364-12122-1-git-send-email-festevam@gmail.com>
Message-ID: <20111109084502.GN12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 09, 2011 at 02:02:44AM -0200, Fabio Estevam wrote:
> diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
> index 7d19425..71f8bec 100644
> --- a/arch/arm/include/asm/mach/arch.h
> +++ b/arch/arm/include/asm/mach/arch.h
> @@ -7,6 +7,7 @@
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>   */
> +#include <asm/mach/irq.h>
>  
>  #ifndef __ASSEMBLY__

Just add a 'struct pt_regs;' declaration along side the other structure
declarations.  We don't need to increase the rats nest of includes to fix
this.
