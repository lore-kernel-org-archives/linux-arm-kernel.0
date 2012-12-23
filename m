From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sun, 23 Dec 2012 18:11:44 +0400
Subject: [PATCH 3/3] ARM: pxa: palmtreo: add docg4 device initialization
In-Reply-To: <1356204719-3317-4-git-send-email-mikedunn@newsguy.com>
References: <1356204719-3317-1-git-send-email-mikedunn@newsguy.com>
 <1356204719-3317-4-git-send-email-mikedunn@newsguy.com>
Message-ID: <50D71120.7040704@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 22-12-2012 23:31, Mike Dunn wrote:

> This patch adds initialization of the docg4 nand flash device to the treo680.

> Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
> ---
>   arch/arm/mach-pxa/palmtreo.c |   31 +++++++++++++++++++++++++++++++
>   1 files changed, 31 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/mach-pxa/palmtreo.c b/arch/arm/mach-pxa/palmtreo.c
> index cb9cc7b..f3e2d08 100644
> --- a/arch/arm/mach-pxa/palmtreo.c
> +++ b/arch/arm/mach-pxa/palmtreo.c
> @@ -404,6 +404,36 @@ static void __init palmtreo_leds_init(void)
>   }
>
>   /******************************************************************************
> + * diskonchip docg4 flash
> + ******************************************************************************/
> +#if defined(CONFIG_MACH_TREO680)
> +/* REVISIT: does the centro have this device also? */
> +#if defined(CONFIG_MTD_NAND_DOCG4) || defined(CONFIG_MTD_NAND_DOCG4_MODULE)

    #if IS_ENABLED(CONFIG_MTD_NAND_DOCG4)

WBR, Sergei
