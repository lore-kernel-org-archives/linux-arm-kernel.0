From: mcuos.com@gmail.com (Wan ZongShun)
Date: Tue, 16 Jul 2013 09:25:45 +0800
Subject: [PATCH] video: nuc900fb: fix to pass correct device identity to
 request_irq()
In-Reply-To: <CAPgLHd9CZ=VponJTbTGKTXVTdvMQM6_T+-RWuPMrk0WYZPbW1Q@mail.gmail.com>
References: <CAPgLHd9CZ=VponJTbTGKTXVTdvMQM6_T+-RWuPMrk0WYZPbW1Q@mail.gmail.com>
Message-ID: <CAKT61h8v2mSHqdREgpvtuQAKC-4j3sKHtJ=c=6-YQdj=JUDyFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/7/16 Wei Yongjun <weiyj.lk@gmail.com>:
> The IRQ handler nuc900fb_irqhandler() use dev_id as a type of
> struct nuc900fb_info *, so we should pass fbi as the device
> identity to request_irq().
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Acked-by: Wan Zongshun <mcuos.com@gmail.com>

Thanks!
Vincent Wan.

> ---
> Was 'video: nuc900fb: fix to pass correct device identity to free_irq()'
> ---
>  drivers/video/nuc900fb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/video/nuc900fb.c b/drivers/video/nuc900fb.c
> index 8c527e5..796e511 100644
> --- a/drivers/video/nuc900fb.c
> +++ b/drivers/video/nuc900fb.c
> @@ -587,8 +587,7 @@ static int nuc900fb_probe(struct platform_device *pdev)
>         fbinfo->flags                   = FBINFO_FLAG_DEFAULT;
>         fbinfo->pseudo_palette          = &fbi->pseudo_pal;
>
> -       ret = request_irq(irq, nuc900fb_irqhandler, 0,
> -                         pdev->name, fbinfo);
> +       ret = request_irq(irq, nuc900fb_irqhandler, 0, pdev->name, fbi);
>         if (ret) {
>                 dev_err(&pdev->dev, "cannot register irq handler %d -err %d\n",
>                         irq, ret);
>
>



--
Wan ZongShun.
www.mcuos.com
