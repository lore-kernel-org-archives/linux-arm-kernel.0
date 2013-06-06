From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Thu, 6 Jun 2013 23:01:21 +0300
Subject: [PATCH 06/10] mmc: dw_mmc-pltfm: add Rockchip variant
In-Reply-To: <201306030059.03783.heiko@sntech.de>
References: <201306030055.15413.heiko@sntech.de>
 <201306030059.03783.heiko@sntech.de>
Message-ID: <CAHp75VdpdP6Xtrv3o0EAKMPBvsMDROTVRQqbb54jpAH=LjFx1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 3, 2013 at 1:59 AM, Heiko St?bner <heiko@sntech.de> wrote:
> Cortex-A9 SoCs from Rockchip use a slightly modified variant of dw_mmc
> controllers that seems to require the SDMMC_CMD_USE_HOLD_REG bit to
> always be set.
>
> There also seem to be no other modifications (additional register etc)
> present, so to keep the footprint low, add this small variant to the
> pltfm driver.

Few comments below.

> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -24,6 +24,16 @@
>
>  #include "dw_mmc.h"
>
> +

No need to add extra empty line here.

> +static void dw_mci_rockchip_prepare_command(struct dw_mci *host, u32 *cmdr)

> @@ -63,20 +73,6 @@ int dw_mci_pltfm_register(struct platform_device *pdev,
>  }
>  EXPORT_SYMBOL_GPL(dw_mci_pltfm_register);
>
> -static int dw_mci_pltfm_probe(struct platform_device *pdev)
> -{
> -       return dw_mci_pltfm_register(pdev, NULL);
> -}
> -
> -int dw_mci_pltfm_remove(struct platform_device *pdev)
> -{
> -       struct dw_mci *host = platform_get_drvdata(pdev);
> -
> -       dw_mci_remove(host);
> -       return 0;
> -}
> -EXPORT_SYMBOL_GPL(dw_mci_pltfm_remove);
> -

If you want to move those through code, please do separate patch.

--
With Best Regards,
Andy Shevchenko
