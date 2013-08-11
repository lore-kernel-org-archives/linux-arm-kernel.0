From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Sun, 11 Aug 2013 17:51:41 +0800
Subject: [PATCH 4/5] ARM: pxa: fix DT auxdata for pxa3xx-gpio
In-Reply-To: <1373555877-29887-5-git-send-email-zonque@gmail.com>
References: <1373555877-29887-1-git-send-email-zonque@gmail.com>
 <1373555877-29887-5-git-send-email-zonque@gmail.com>
Message-ID: <CAD6h2NTsgty35bJEbQcaxCroWprsz14k1uyLuybcLTOoSqiSOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 July 2013 23:17, Daniel Mack <zonque@gmail.com> wrote:
> Commit f87311743 ("ARM: mmp: add more compatible names in gpio driver")
> changed the DT match string for pxa3xx-gpio, but left the auxdata table
> unchanged.
>
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-pxa/pxa-dt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-pxa/pxa-dt.c b/arch/arm/mach-pxa/pxa-dt.c
> index 3835979..f6a2c4b 100644
> --- a/arch/arm/mach-pxa/pxa-dt.c
> +++ b/arch/arm/mach-pxa/pxa-dt.c
> @@ -28,7 +28,7 @@ static const struct of_dev_auxdata pxa3xx_auxdata_lookup[] __initconst = {
>         OF_DEV_AUXDATA("mrvl,pxa-uart",         0x40700000, "pxa2xx-uart.2", NULL),
>         OF_DEV_AUXDATA("mrvl,pxa-uart",         0x41600000, "pxa2xx-uart.3", NULL),
>         OF_DEV_AUXDATA("marvell,pxa-mmc",       0x41100000, "pxa2xx-mci.0", NULL),
> -       OF_DEV_AUXDATA("mrvl,pxa-gpio",         0x40e00000, "pxa-gpio", NULL),
> +       OF_DEV_AUXDATA("intel,pxa3xx-gpio",     0x40e00000, "pxa3xx-gpio", NULL),
>         OF_DEV_AUXDATA("marvell,pxa-ohci",      0x4c000000, "pxa27x-ohci", NULL),
>         OF_DEV_AUXDATA("mrvl,pxa-i2c",          0x40301680, "pxa2xx-i2c.0", NULL),
>         OF_DEV_AUXDATA("mrvl,pwri2c",           0x40f500c0, "pxa3xx-i2c.1", NULL),
> --
> 1.8.1.4
>

Applied.

Regards
Haojian
