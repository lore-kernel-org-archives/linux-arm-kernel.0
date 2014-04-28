From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 28 Apr 2014 13:02:19 +0200
Subject: [PATCH RESEND 1/3] mmc: mvsdio: silence card detect notice
In-Reply-To: <1398540855-27367-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1398540855-27367-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1398540855-27367-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <CAPDyKFr+R0cV2gDxEV5j7Z1vpaz_XOkHjbgPN-JRF21Ymamdeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 April 2014 21:34, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:
> mvsdio reports method of card detection with dev_notice, while for
> removable cards it may be sane, for non-removable cards it is not.
> Also, as the user cannot do anything about it, silence the message
> by reducing it from dev_notice to dev_dbg.
>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Acked-by: Jason Cooper <jason@lakedaemon.net>
> ---
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: Chris Ball <chris@printf.net>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: linux-mmc at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/mmc/host/mvsdio.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
> index 45aa2206741d..41aca7f28c23 100644
> --- a/drivers/mmc/host/mvsdio.c
> +++ b/drivers/mmc/host/mvsdio.c
> @@ -801,10 +801,10 @@ static int mvsd_probe(struct platform_device *pdev)
>                 goto out;
>
>         if (!(mmc->caps & MMC_CAP_NEEDS_POLL))
> -               dev_notice(&pdev->dev, "using GPIO for card detection\n");
> +               dev_dbg(&pdev->dev, "using GPIO for card detection\n");
>         else
> -               dev_notice(&pdev->dev,
> -                          "lacking card detect (fall back to polling)\n");
> +               dev_dbg(&pdev->dev, "lacking card detect (fall back to polling)\n");
> +
>         return 0;
>
>  out:
> --
> 1.9.1
>
