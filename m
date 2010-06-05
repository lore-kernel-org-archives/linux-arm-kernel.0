From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 5 Jun 2010 15:14:55 +0800
Subject: [PATCH 2/3] MTD/pxa: use __devinit for pxa2xx_flash_probe
In-Reply-To: <4C09F25E.8090908@gmail.com>
References: <4C09F25E.8090908@gmail.com>
Message-ID: <AANLkTillJtAYn653DamU7_u3fmKt7rKGJtwfCHPPUVUF@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/6/5 Wan ZongShun <mcuos.com@gmail.com>:
> This patch is to use the '__devinit' for pxa2xx_flash_probe.
>
>
> Signed-off-by :Wan ZongShun <mcuos.com@gmail.com>

Acked.

> ---
> ?drivers/mtd/maps/pxa2xx-flash.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mtd/maps/pxa2xx-flash.c b/drivers/mtd/maps/pxa2xx-flash.c
> index 1d2583f..43f8bb8 100644
> --- a/drivers/mtd/maps/pxa2xx-flash.c
> +++ b/drivers/mtd/maps/pxa2xx-flash.c
> @@ -51,7 +51,7 @@ struct pxa2xx_flash_info {
> ?static const char *probes[] = { "RedBoot", "cmdlinepart", NULL };
>
>
> -static int __init pxa2xx_flash_probe(struct platform_device *pdev)
> +static int __devinit pxa2xx_flash_probe(struct platform_device *pdev)
> ?{
> ? ? ? ?struct flash_platform_data *flash = pdev->dev.platform_data;
> ? ? ? ?struct pxa2xx_flash_info *info;
> --
> 1.6.3.3
>
