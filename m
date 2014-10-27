From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 27 Oct 2014 14:39:04 +0100
Subject: [PATCH RESEND 03/12] mmc: sdhci-pxav3: Move private driver data
 to driver source
In-Reply-To: <1413883364-681-4-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1413883364-681-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1413883364-681-4-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <CAPDyKFo+sSgc+J5uiNyhzwF69ncLmo7aoVgUB5O1JA4MrhhPbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 October 2014 11:22, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:
> struct sdhci_pxa is only used in sdhci_pxa driver itself, so move it
> there.
>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Thanks! Applied for next!

Kind regards
Uffe


> ---
> Cc: Chris Ball <chris@printf.net>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: "Antoine T?nart" <antoine.tenart@free-electrons.com>
> Cc: linux-mmc at vger.kernel.org
> Cc: devicetree at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  drivers/mmc/host/sdhci-pxav3.c          | 5 +++++
>  include/linux/platform_data/pxa_sdhci.h | 5 -----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index b55c807982fe..48bc8179c8fc 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -58,6 +58,11 @@
>  #define SDCE_MISC_INT          (1<<2)
>  #define SDCE_MISC_INT_EN       (1<<1)
>
> +struct sdhci_pxa {
> +       u8      clk_enable;
> +       u8      power_mode;
> +};
> +
>  /*
>   * These registers are relative to the second register region, for the
>   * MBus bridge.
> diff --git a/include/linux/platform_data/pxa_sdhci.h b/include/linux/platform_data/pxa_sdhci.h
> index 27d3156d093a..9e20c2fb4ffd 100644
> --- a/include/linux/platform_data/pxa_sdhci.h
> +++ b/include/linux/platform_data/pxa_sdhci.h
> @@ -55,9 +55,4 @@ struct sdhci_pxa_platdata {
>         unsigned int    quirks2;
>         unsigned int    pm_caps;
>  };
> -
> -struct sdhci_pxa {
> -       u8      clk_enable;
> -       u8      power_mode;
> -};
>  #endif /* _PXA_SDHCI_H_ */
> --
> 2.1.1
>
