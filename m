From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 1 Jun 2015 10:05:42 +0200
Subject: [PATCH v2 1/2] mmc: sdhci-bcm2835: Clean up platform allocations
 if sdhci init fails.
In-Reply-To: <1432933572-8695-1-git-send-email-eric@anholt.net>
References: <1432933572-8695-1-git-send-email-eric@anholt.net>
Message-ID: <CAPDyKFpah1Ym4wAVk3PN1PN8QoQjTNijbwBd3kT0QdKMqP0wWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 May 2015 at 23:06, Eric Anholt <eric@anholt.net> wrote:
> Signed-off-by: Eric Anholt <eric@anholt.net>

Thanks, applied!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-bcm2835.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-bcm2835.c b/drivers/mmc/host/sdhci-bcm2835.c
> index 0ef0343..32f4046 100644
> --- a/drivers/mmc/host/sdhci-bcm2835.c
> +++ b/drivers/mmc/host/sdhci-bcm2835.c
> @@ -173,8 +173,11 @@ static int bcm2835_sdhci_probe(struct platform_device *pdev)
>                 goto err;
>         }
>
> -       return sdhci_add_host(host);
> +       ret = sdhci_add_host(host);
> +       if (ret)
> +               goto err;
>
> +       return 0;
>  err:
>         sdhci_pltfm_free(pdev);
>         return ret;
> --
> 2.1.4
>
