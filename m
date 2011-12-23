From: balajitk@ti.com (T Krishnamoorthy, Balaji)
Date: Fri, 23 Dec 2011 21:10:26 +0530
Subject: [PATCH] ARM: OMAP: hsmmc: add max_freq field
In-Reply-To: <1323868927-3738-1-git-send-email-zonque@gmail.com>
References: <1323868927-3738-1-git-send-email-zonque@gmail.com>
Message-ID: <CANrkHUY3Zf4a2K5769Z=7Wng339zB6+z_Tgd4mOPChZ1RvZ=Kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 6:52 PM, Daniel Mack <zonque@gmail.com> wrote:
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 101cd31..8215ef9 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1927,8 +1927,12 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
> ? ? ? ?if (mmc_slot(host).vcc_aux_disable_is_sleep)
> ? ? ? ? ? ? ? ?mmc_slot(host).no_off = 1;
>
> - ? ? ? mmc->f_min ? ? ?= OMAP_MMC_MIN_CLOCK;
> - ? ? ? mmc->f_max ? ? ?= OMAP_MMC_MAX_CLOCK;
> + ? ? ? mmc->f_min = OMAP_MMC_MIN_CLOCK;

Stray change for f_min ?
