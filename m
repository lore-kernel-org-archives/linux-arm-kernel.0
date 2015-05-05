From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 5 May 2015 10:36:21 +0200
Subject: [PATCH 1/6] mmc: davinci: Constify platform_device_id
In-Reply-To: <1430495362-31506-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430495362-31506-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <CAPDyKFrpTiztS1UrMQRXX4o9=s1L7qzX9JTdNNHQUrx5sa5aiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 May 2015 at 17:49, Krzysztof Kozlowski <k.kozlowski.k@gmail.com> wrote:
> The platform_device_id is not modified by the driver and core uses it as
> const.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

Thanks, applied all patches (1->6). The last one I updated the prefix
in commit message header to "sdhci".

Kind regards
Uffe

> ---
>  drivers/mmc/host/davinci_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index 1625f908dc70..ea2a2ebc6b91 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -1161,7 +1161,7 @@ static void __init init_mmcsd_host(struct mmc_davinci_host *host)
>         mmc_davinci_reset_ctrl(host, 0);
>  }
>
> -static struct platform_device_id davinci_mmc_devtype[] = {
> +static const struct platform_device_id davinci_mmc_devtype[] = {
>         {
>                 .name   = "dm6441-mmc",
>                 .driver_data = MMC_CTLR_VERSION_1,
> --
> 2.1.4
>
