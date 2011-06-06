From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 6 Jun 2011 16:45:57 +0800
Subject: [PATCH] arm/mxs: Fix build failure on ocotp.c
In-Reply-To: <20110606074024.23861.55150.stgit@ponder>
References: <20110606074024.23861.55150.stgit@ponder>
Message-ID: <20110606084555.GA21204@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2011 at 01:40:38AM -0600, Grant Likely wrote:
> arch/arm/mach-mxs/ocotp.c needs to include asm/processor.h to get the
> definition of cpu_relax().
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>  arch/arm/mach-mxs/ocotp.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/ocotp.c b/arch/arm/mach-mxs/ocotp.c
> index 65157a3..c7a4d34 100644
> --- a/arch/arm/mach-mxs/ocotp.c
> +++ b/arch/arm/mach-mxs/ocotp.c
> @@ -16,6 +16,8 @@
>  #include <linux/err.h>
>  #include <linux/mutex.h>
>  
> +#include <asm/processor.h>
> +
>  #include <mach/mxs.h>
>  
>  #define OCOTP_WORD_OFFSET		0x20
> 
> --

Wolfram had sent a fix for this.  But it has not hit the mainline.

https://patchwork.kernel.org/patch/815482/

-- 
Regards,
Shawn
