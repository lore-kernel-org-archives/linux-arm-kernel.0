From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 13 Mar 2013 15:22:56 +0100
Subject: [PATCH 3/3] ARM: at91: renamme rm9200 dt file
In-Reply-To: <1362666113-16434-3-git-send-email-plagnioj@jcrosoft.com>
References: <20130307130842.GA4590@game.jcrosoft.org>
 <1362666113-16434-1-git-send-email-plagnioj@jcrosoft.com>
 <1362666113-16434-3-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <51408BC0.6020109@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/07/2013 03:21 PM, Jean-Christophe PLAGNIOL-VILLARD :
> to follow the same scheme board-dt-<socs>.c

Well not <socs> as each and every SoC will not have its own board file.
I confess that finding a proper name is not easy, what about:

Rename the board-rm9200-dt.c file so that we follow the pattern for
Device Tree board files: board-dt-<name of SoC sharing same core>.c

Best regards,

> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> ---
>  arch/arm/mach-at91/Makefile                                 |    2 +-
>  arch/arm/mach-at91/{board-rm9200-dt.c => board-dt-rm9200.c} |    0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename arch/arm/mach-at91/{board-rm9200-dt.c => board-dt-rm9200.c} (100%)
> 
> diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
> index 5eca35a..505fed9 100644
> --- a/arch/arm/mach-at91/Makefile
> +++ b/arch/arm/mach-at91/Makefile
> @@ -87,7 +87,7 @@ obj-$(CONFIG_MACH_SNAPPER_9260)	+= board-snapper9260.o
>  obj-$(CONFIG_MACH_AT91SAM9M10G45EK) += board-sam9m10g45ek.o
>  
>  # AT91SAM board with device-tree
> -obj-$(CONFIG_MACH_AT91RM9200_DT) += board-rm9200-dt.o
> +obj-$(CONFIG_MACH_AT91RM9200_DT) += board-dt-rm9200.o
>  obj-$(CONFIG_MACH_AT91SAM9_DT) += board-dt-sam9.o
>  
>  # AT91X40 board-specific support
> diff --git a/arch/arm/mach-at91/board-rm9200-dt.c b/arch/arm/mach-at91/board-dt-rm9200.c
> similarity index 100%
> rename from arch/arm/mach-at91/board-rm9200-dt.c
> rename to arch/arm/mach-at91/board-dt-rm9200.c
> 


-- 
Nicolas Ferre
