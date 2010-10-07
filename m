From: vimal.newwork@gmail.com (Vimal Singh)
Date: Thu, 7 Oct 2010 23:05:10 +0530
Subject: [PATCH v3] OMAP: NAND: Fix static declaration warning
In-Reply-To: <1286315819-5906-1-git-send-email-manjugk@ti.com>
References: <1286315819-5906-1-git-send-email-manjugk@ti.com>
Message-ID: <AANLkTin-rjxxDpiN9V5CinWr4cCqH1QB=cEH+huEcxYv@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 6, 2010 at 3:26 AM, G, Manjunath Kondaiah <manjugk@ti.com> wrote:
> This patch fixes sparse warning for static declaration of variable "use_dma"
>
> drivers/mtd/nand/omap2.c:114:11: warning: symbol 'use_dma' was not declared. Should it be static?
>
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-mtd at lists.infradead.org
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Nishanth Menon <nm@ti.com>
> ---
> Changes since v1:
> ?- no logical changes, patch seperated from series based Tony's suggestion.
>
> ?drivers/mtd/nand/omap2.c | ? ?4 ++--
> ?1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 133d515..439e80d 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -111,11 +111,11 @@ static int use_dma = 1;
> ?module_param(use_dma, bool, 0);
> ?MODULE_PARM_DESC(use_dma, "enable/disable use of DMA");
> ?#else
> -const int use_dma;
> +static const int use_dma;
> ?#endif
> ?#else
> ?const int use_prefetch;
> -const int use_dma;
> +static const int use_dma;

I did not understand, why did it not pointed same error for 'const int
use_prefetch'?

-- 
Regards,
Vimal Singh
