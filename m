From: will.deacon@arm.com (Will Deacon)
Date: Thu, 11 Jun 2015 10:32:07 +0100
Subject: [PATCH 1/1] arm/hw_breakpoint.c: Added #include <linux/kdebug.h>
 instead of<asm/kdebug.h>
In-Reply-To: <"000501d0a427$ad431980$07c94c80$@s"@samsung.com>
References: <"000501d0a427$ad431980$07c94c80$@s"@samsung.com>
Message-ID: <20150611093207.GA15078@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 11, 2015 at 10:18:44AM +0100, Maninder Singh wrote:
> This patch fixes below checkpatch.pl warning:
> WARNING: Use #include <linux/kdebug.h> instead of <asm/kdebug.h>
> 
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> Reviewed-by: Vaneet Narang <v.narang@samsung.com>
> ---
> arch/arm/kernel/hw_breakpoint.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
> index dc7d0a9..86eef81 100644
> --- a/arch/arm/kernel/hw_breakpoint.c
> +++ b/arch/arm/kernel/hw_breakpoint.c
> @@ -35,7 +35,7 @@
> #include <asm/cputype.h>
> #include <asm/current.h>
> #include <asm/hw_breakpoint.h>
> -#include <asm/kdebug.h>
> +#include <linux/kdebug.h>
> #include <asm/traps.h>
>  /* Breakpoint currently in use for each BRP. */

afaict, we don't even need the header so we can just drop the #include
altogether. Same for arm64.

Will
