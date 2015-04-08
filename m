From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 8 Apr 2015 12:08:03 +0200
Subject: [PATCH] mmc: sdhci-of-arasan: Call OF parsing for MMC
In-Reply-To: <35949221633dcbb490c3c28b8099c5be00cb9730.1428386249.git.michal.simek@xilinx.com>
References: <35949221633dcbb490c3c28b8099c5be00cb9730.1428386249.git.michal.simek@xilinx.com>
Message-ID: <CAPDyKFqoDOpdRaq=yMQGfwnk6_UVkT0Uqurhx3602+vXz1jaeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 April 2015 at 07:57, Michal Simek <michal.simek@xilinx.com> wrote:
> Also check MMC OF properties. The controller supports MMC too.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Thanks! Applied.

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/sdhci-of-arasan.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index bcb51e9..b8cfac1 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -173,6 +173,12 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>         pltfm_host->priv = sdhci_arasan;
>         pltfm_host->clk = clk_xin;
>
> +       ret = mmc_of_parse(host->mmc);
> +       if (ret) {
> +               dev_err(&pdev->dev, "parsing dt failed (%u)\n", ret);
> +               goto clk_disable_all;
> +       }
> +
>         ret = sdhci_add_host(host);
>         if (ret)
>                 goto err_pltfm_free;
> --
> 1.7.2.3
>
