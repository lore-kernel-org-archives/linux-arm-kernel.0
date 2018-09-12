From: vaibhav.sr@gmail.com (Vaibhav Agarwal)
Date: Wed, 12 Sep 2018 11:29:31 +0530
Subject: [PATCH] staging: remove unneeded static set .owner field in
 platform_driver
In-Reply-To: <1536723628-50914-1-git-send-email-zhongjiang@huawei.com>
References: <1536723628-50914-1-git-send-email-zhongjiang@huawei.com>
Message-ID: <CAAs364_nffauHCKdzpvb5+n01FtkKHRCj4DL=MC7oworXgOSTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2018 at 9:22 AM zhong jiang <zhongjiang@huawei.com> wrote:
>
> platform_driver_register will set the .owner field. So it is safe
> to remove the redundant assignment.
>
> The issue is detected with the help of Coccinelle.
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/staging/greybus/audio_codec.c    | 1 -
>  drivers/staging/mt7621-eth/gsw_mt7621.c  | 1 -
>  drivers/staging/mt7621-eth/mtk_eth_soc.c | 1 -
>  3 files changed, 3 deletions(-)
>
> diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
> index 35acd55..08746c8 100644
> --- a/drivers/staging/greybus/audio_codec.c
> +++ b/drivers/staging/greybus/audio_codec.c
> @@ -1087,7 +1087,6 @@ static int gbaudio_codec_remove(struct platform_device *pdev)
>  static struct platform_driver gbaudio_codec_driver = {
>         .driver = {
>                 .name = "apb-dummy-codec",
> -               .owner = THIS_MODULE,
>  #ifdef CONFIG_PM
>                 .pm = &gbaudio_codec_pm_ops,
>  #endif
> diff --git a/drivers/staging/mt7621-eth/gsw_mt7621.c b/drivers/staging/mt7621-eth/gsw_mt7621.c
> index 2c07b55..53767b1 100644
> --- a/drivers/staging/mt7621-eth/gsw_mt7621.c
> +++ b/drivers/staging/mt7621-eth/gsw_mt7621.c
> @@ -286,7 +286,6 @@ static int mt7621_gsw_remove(struct platform_device *pdev)
>         .remove = mt7621_gsw_remove,
>         .driver = {
>                 .name = "mt7621-gsw",
> -               .owner = THIS_MODULE,
>                 .of_match_table = mediatek_gsw_match,
>         },
>  };
> diff --git a/drivers/staging/mt7621-eth/mtk_eth_soc.c b/drivers/staging/mt7621-eth/mtk_eth_soc.c
> index 7135075..363d3c9 100644
> --- a/drivers/staging/mt7621-eth/mtk_eth_soc.c
> +++ b/drivers/staging/mt7621-eth/mtk_eth_soc.c
> @@ -2167,7 +2167,6 @@ static int mtk_remove(struct platform_device *pdev)
>         .remove = mtk_remove,
>         .driver = {
>                 .name = "mtk_soc_eth",
> -               .owner = THIS_MODULE,
>                 .of_match_table = of_mtk_match,
>         },
>  };
> --
> 1.7.12.4
>

Acked-by: Vaibhav Agarwal <vaibhav.sr@gmail.com>
