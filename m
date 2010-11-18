From: b-cousson@ti.com (Cousson, Benoit)
Date: Thu, 18 Nov 2010 22:42:50 +0100
Subject: [PATCH] OMAP4: clocks: add dummy clock for mailbox
In-Reply-To: <1290108000-16835-1-git-send-email-h-kanigeri2@ti.com>
References: <1290108000-16835-1-git-send-email-h-kanigeri2@ti.com>
Message-ID: <4CE59DDA.30205@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hari,

On 11/18/2010 8:20 PM, Kanigeri, Hari wrote:
> In omap4, there is no explicit configuration register to enable mailbox clocks.
> Defining dummy clock for mailbox clock module to keep the mailbox driver
> backward compatible with previous omaps.
>
> Signed-off-by: Hari Kanigeri<h-kanigeri2@ti.com>
> ---
>   arch/arm/mach-omap2/clock44xx_data.c |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
> index e10db7a..bdd9b85 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -2687,6 +2687,7 @@ static struct omap_clk omap44xx_clks[] = {
>   	CLK(NULL,	"uart3_ick",			&dummy_ck,	CK_443X),
>   	CLK(NULL,	"uart4_ick",			&dummy_ck,	CK_443X),
>   	CLK("omap_wdt",	"ick",				&dummy_ck,	CK_443X),
> +	CLK(NULL,	"mailboxes_ick",	&dummy_ck,	CK_443X),
>   };
>
>   int __init omap4xxx_clk_init(void)

OK, that one is easy but... I will still have to update the script to 
generate it, so:

Acked-by: Benoit Cousson <b-cousson@ti.com>

Regards,
Benoit
