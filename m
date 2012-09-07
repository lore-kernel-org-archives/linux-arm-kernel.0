From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Fri, 7 Sep 2012 09:27:27 +0200
Subject: [PATCH v2] gpio: samsung: add devicetree init for s3c24xx arches
In-Reply-To: <243901cd8cbb$10ad0580$32071080$%kim@samsung.com>
References: <201208282355.44268.heiko@sntech.de>
 <243901cd8cbb$10ad0580$32071080$%kim@samsung.com>
Message-ID: <201209070927.28405.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 7. September 2012, 07:38:52 schrieb Kukjin Kim:
> Heiko St?bner wrote:
> > Until now the Exynos-SoC was the only Samsung-SoC supporting the GPIOs
> > via the device tree. This patch implements dt-support for the
> > s3c24xx arches.
> > 
> > The controllers contain only 3 cells, as the underlying gpio controller
> > does not support controlling the drive strength on a gpio level.
> > 
> > Tested with the gpio-keys driver on a s3c2416 based machine.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > Reviewed-by: Thomas Abraham <thomas.abraham@linaro.org>
> > ---
> 
> [...]
> 
> > +#if defined(CONFIG_PLAT_S3C24XX) && defined(CONFIG_OF)
> 
> [...]
> 
> > +static __init void s3c24xx_gpiolib_attach_ofnode(struct
> > samsung_gpio_chip *chip,
> > +						 u64 base, u64 offset)
> > +{
> 
> [...]
> 
> > +}
> > +#elif defined(CONFIG_PLAT_S3C24XX)
> 
> Heiko, above line breaks building for other samsung stuff except s3c24xx. I
> fixed with following which has been amended in your patch. If any
> problems, please let me know.

yeah, I see the problem now. Thanks for the fix and sorry to have caused 
additional work.


Heiko
