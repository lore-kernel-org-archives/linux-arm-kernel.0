From: stripathi@apm.com (Suman Tripathi)
Date: Fri, 19 Jun 2015 17:58:02 +0530
Subject: [PATCH v8 2/2] mmc: host: sdhci: Disable 1.8V signaling for
 arasan 4.9a version of SDHCI controller.
In-Reply-To: <1434715227-27399-3-git-send-email-stripathi@apm.com>
References: <1434715227-27399-1-git-send-email-stripathi@apm.com>
 <1434715227-27399-3-git-send-email-stripathi@apm.com>
Message-ID: <CAOHikRBkDinUfcOR3Dg12e2Xy_P5TABOpHSnkSpZhRyhLRWGFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ,

On Fri, Jun 19, 2015 at 5:30 PM, Suman Tripathi <stripathi@apm.com> wrote:
> This patch disables the 1.8V signaling for arasan 4.9a version
> of SDHCI controller with the help SDHCI_QUIRK2_NO_1_8_V quirk.
>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> ---
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 21c0c08..4c99ea4 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -171,7 +171,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>
>         if (of_device_is_compatible(pdev->dev.of_node, "arasan,sdhci-4.9a")) {
>                 host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
> -               host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
> +               host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23 |
> +                                SDHCI_QUIRK2_NO_1_8_V;
>         }


I think I am  wrong here. No-1.8v is something related to board
regulator circuitry not related to IP version. So it should be dts
driven.

>
>         sdhci_get_of_property(pdev);
> --
> 1.8.2.1
>



-- 
Thanks,
with regards,
Suman Tripathi
