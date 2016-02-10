From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 10 Feb 2016 17:39:57 +0100
Subject: [PATCH v5 RESEND 2/5] ARM: sa1111: ensure no negative value gets
 returned on positive match
In-Reply-To: <1455101250-11327-3-git-send-email-m.szyprowski@samsung.com>
References: <1455101250-11327-1-git-send-email-m.szyprowski@samsung.com>
 <1455101250-11327-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CAPDyKFqJTB=Q=uQtqHVy7_ssoDyUSDZtB7H+k00QFnwXqDkzDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 February 2016 at 11:47, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> This patch ensures that existing bus match callbacks don't return
> negative values (which might be interpreted as potential errors in the
> future) in case of positive match.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

FYI:
This one has actually been acked by Russell.
https://lkml.org/lkml/2015/12/23/111

Kind regards
Uffe

> ---
>  arch/arm/common/sa1111.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
> index 3d22494..fb0a0a4 100644
> --- a/arch/arm/common/sa1111.c
> +++ b/arch/arm/common/sa1111.c
> @@ -1290,7 +1290,7 @@ static int sa1111_match(struct device *_dev, struct device_driver *_drv)
>         struct sa1111_dev *dev = SA1111_DEV(_dev);
>         struct sa1111_driver *drv = SA1111_DRV(_drv);
>
> -       return dev->devid & drv->devid;
> +       return !!(dev->devid & drv->devid);
>  }
>
>  static int sa1111_bus_suspend(struct device *dev, pm_message_t state)
> --
> 1.9.2
>
