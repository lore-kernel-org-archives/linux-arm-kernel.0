From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 28 Jul 2010 14:17:23 +0800
Subject: [PATCH 02/29] pxa3xx_nand: fix compile warning
In-Reply-To: <AANLkTimJbfRUwzRUT0Z6_eMOm-SpYeti-FjY-eE5a7cV@mail.gmail.com>
References: <AANLkTimJbfRUwzRUT0Z6_eMOm-SpYeti-FjY-eE5a7cV@mail.gmail.com>
Message-ID: <AANLkTikHFbaUjocnH9Fm8EHV75rCFEZ03EkMqbWPzHc+@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 28, 2010 at 1:56 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> From c374a3f27c56f9112b97960eaa3194a08db6f4a4 Mon Sep 17 00:00:00 2001
> From: Lei Wen <leiwen@marvell.com>
> Date: Tue, 22 Jun 2010 20:19:35 +0800
> Subject: [PATCH 02/29] pxa3xx_nand: fix compile warning
>
> The compile output as below:
> WARNING: modpost: Found 1 section mismatch(es).
>
> Signed-off-by: Lei Wen <leiwen@marvell.com>
> ---
> ?drivers/mtd/nand/pxa3xx_nand.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
> index 3ffcbcd..52cec28 100644
> --- a/drivers/mtd/nand/pxa3xx_nand.c
> +++ b/drivers/mtd/nand/pxa3xx_nand.c
> @@ -1069,7 +1069,7 @@ static void pxa3xx_nand_init_mtd(struct mtd_info *mtd,
> ? ? ? ?this->chip_delay = 25;
> ?}
>
> -static int pxa3xx_nand_probe(struct platform_device *pdev)
> +static int __devinit pxa3xx_nand_probe(struct platform_device *pdev)

Ack

> ?{
> ? ? ? ?struct pxa3xx_nand_platform_data *pdata;
> ? ? ? ?struct pxa3xx_nand_info *info;
> --
> 1.7.0.4
>
