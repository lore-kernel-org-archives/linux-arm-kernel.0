From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Wed, 5 Jun 2013 16:11:21 +0200
Subject: [PATCH 06/10] mmc: dw_mmc-pltfm: add Rockchip variant
In-Reply-To: <001601ce61f5$11b37b20$351a7160$%jun@samsung.com>
References: <201306030055.15413.heiko@sntech.de>
 <201306030059.03783.heiko@sntech.de>
 <001601ce61f5$11b37b20$351a7160$%jun@samsung.com>
Message-ID: <201306051611.21669.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 5. Juni 2013, 16:00:43 schrieb Seungwon Jeon:
> On 06/03/13 7:59 AM, Heiko St?bner wrote:
> > Cortex-A9 SoCs from Rockchip use a slightly modified variant of dw_mmc
> > controllers that seems to require the SDMMC_CMD_USE_HOLD_REG bit to
> > always be set.
> > 
> > There also seem to be no other modifications (additional register etc)
> > present, so to keep the footprint low, add this small variant to the
> > pltfm driver.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > 
> >  drivers/mmc/host/dw_mmc-pltfm.c |   48
> >  +++++++++++++++++++++++++++----------- 1 files changed, 34
> >  insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/dw_mmc-pltfm.c
> > b/drivers/mmc/host/dw_mmc-pltfm.c index 0048da8..7d041b5 100644
> > --- a/drivers/mmc/host/dw_mmc-pltfm.c
> > +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> > @@ -24,6 +24,16 @@
> > 
> >  #include "dw_mmc.h"
> > 
> > +
> > +static void dw_mci_rockchip_prepare_command(struct dw_mci *host, u32
> > *cmdr) +{
> > +	*cmdr |= SDMMC_CMD_USE_HOLD_REG;
> 
> Currently, SDMMC_CMD_USE_HOLD_REG is defined in dw_mmc-exynos.c
> It should be moved to dw_mmc.h

It's already done in another patch "mmc: dw_mmc: Add support DW SD/MMC driver 
on SOCFPGA" from Dinh Nguyen <dinguyen@altera.com>, which I therefore named as 
dependency in the cover letter.

Don't know if it's better to also include the move here again and let the 
merging person sort out the conflict?
