From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sun, 9 Dec 2012 00:24:53 +0800
Subject: [PATCH 03/20] ALSA: pxa2xx: remove __dev* attributes
In-Reply-To: <1354815329-20221-4-git-send-email-wfp5p@virginia.edu>
References: <1354815329-20221-1-git-send-email-wfp5p@virginia.edu>
 <1354815329-20221-4-git-send-email-wfp5p@virginia.edu>
Message-ID: <CAN1soZz2c83dyfbEmqkX6ORH_X_fuNeS4gugdKuqbk-bgaukDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 7, 2012 at 1:35 AM, Bill Pemberton <wfp5p@virginia.edu> wrote:
> CONFIG_HOTPLUG is going away as an option.  As result the __dev*
> markings will be going away.
>
> Remove use of __devinit, __devexit_p, __devinitdata, __devinitconst,
> and __devexit.
>
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  sound/arm/pxa2xx-ac97-lib.c | 2 +-
>  sound/arm/pxa2xx-ac97.c     | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
> index 48d7c0a..6fc0ae9 100644
> --- a/sound/arm/pxa2xx-ac97-lib.c
> +++ b/sound/arm/pxa2xx-ac97-lib.c
> @@ -314,7 +314,7 @@ int pxa2xx_ac97_hw_resume(void)
>  EXPORT_SYMBOL_GPL(pxa2xx_ac97_hw_resume);
>  #endif
>
> -int __devinit pxa2xx_ac97_hw_probe(struct platform_device *dev)
> +int pxa2xx_ac97_hw_probe(struct platform_device *dev)
>  {
>         int ret;
>         pxa2xx_audio_ops_t *pdata = dev->dev.platform_data;
> diff --git a/sound/arm/pxa2xx-ac97.c b/sound/arm/pxa2xx-ac97.c
> index 4e1fda7..ec54be4 100644
> --- a/sound/arm/pxa2xx-ac97.c
> +++ b/sound/arm/pxa2xx-ac97.c
> @@ -163,7 +163,7 @@ static int pxa2xx_ac97_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(pxa2xx_ac97_pm_ops, pxa2xx_ac97_suspend, pxa2xx_ac97_resume);
>  #endif
>
> -static int __devinit pxa2xx_ac97_probe(struct platform_device *dev)
> +static int pxa2xx_ac97_probe(struct platform_device *dev)
>  {
>         struct snd_card *card;
>         struct snd_ac97_bus *ac97_bus;
> @@ -224,7 +224,7 @@ err_dev:
>         return ret;
>  }
>
> -static int __devexit pxa2xx_ac97_remove(struct platform_device *dev)
> +static int pxa2xx_ac97_remove(struct platform_device *dev)
>  {
>         struct snd_card *card = platform_get_drvdata(dev);
>
> @@ -239,7 +239,7 @@ static int __devexit pxa2xx_ac97_remove(struct platform_device *dev)
>
>  static struct platform_driver pxa2xx_ac97_driver = {
>         .probe          = pxa2xx_ac97_probe,
> -       .remove         = __devexit_p(pxa2xx_ac97_remove),
> +       .remove         = pxa2xx_ac97_remove,
>         .driver         = {
>                 .name   = "pxa2xx-ac97",
>                 .owner  = THIS_MODULE,
> --
> 1.8.0.1
>

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
