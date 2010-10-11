From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 11 Oct 2010 17:06:05 +0800
Subject: [PATCH 13/14 RESEND] ARM: pxa: Fix pxa2xx-flash section mismatch
In-Reply-To: <1286756432-5873-13-git-send-email-marek.vasut@gmail.com>
References: <1286756432-5873-1-git-send-email-marek.vasut@gmail.com>
	<1286756432-5873-13-git-send-email-marek.vasut@gmail.com>
Message-ID: <AANLkTi=tB64mxGaifSy1ye-tB2KiiH-y-hMmiGAhA7EH@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 11, 2010 at 8:20 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> ---
> ?drivers/mtd/maps/pxa2xx-flash.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mtd/maps/pxa2xx-flash.c b/drivers/mtd/maps/pxa2xx-flash.c
> index dd90880..d8ae634 100644
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
> 1.7.1
>
>

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
