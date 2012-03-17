From: lost.distance@yahoo.com (Paul Parsons)
Date: Sat, 17 Mar 2012 14:48:37 +0000 (GMT)
Subject: [PATCH] pxa/hx4700: fix the LCD initialization
In-Reply-To: <1331905213.29979.1.camel@flow>
Message-ID: <1331995717.82481.YahooMailClassic@web29016.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Philipp

--- On Fri, 16/3/12, Philipp Zabel <philipp.zabel@gmail.com> wrote:
> Common sense and the SDG bootldr code
> reference dictate that
> N2.7V/7.3V be disabled here, and not LVDD, which already
> was
> disabled 10 ms earlier.
> This should only have an effect if the LCD was enabled in
> the
> bootloader.
> 
> Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Paul Parsons <lost.distance@yahoo.com>
> ---
>  arch/arm/mach-pxa/hx4700.c |? ? 2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/hx4700.c
> b/arch/arm/mach-pxa/hx4700.c
> index 61bb967..31c6dd1 100644
> --- a/arch/arm/mach-pxa/hx4700.c
> +++ b/arch/arm/mach-pxa/hx4700.c
> @@ -399,7 +399,7 @@ static void sony_lcd_init(void)
>  ??? gpio_set_value(GPIO62_HX4700_LCD_nRESET,
> 0);
>  ??? mdelay(10);
>  ??? gpio_set_value(GPIO59_HX4700_LCD_PC1,
> 0);
> -???
> gpio_set_value(GPIO110_HX4700_LCD_LVDD_3V3_ON, 0);
> +???
> gpio_set_value(GPIO112_HX4700_LCD_N2V7_7V3_ON, 0);
>  ??? mdelay(20);
>  
>  ???
> gpio_set_value(GPIO110_HX4700_LCD_LVDD_3V3_ON, 1);
> -- 

After some experimenting it seems that neither GPIO110 "LCD_LVDD_3V3_ON"
nor GPIO112 "LCD_N2V7_7V3_ON" have any effect on the hx4700 LCD.
After the hx4700 boots I can turn either one off, or both off together,
and the LCD and touchscreen will continue to work normally.

Is there an authoritative description of the 7 "LCD" GPIOs (GPIO59,
GPIO62, GPIO70, GPIO84, GPIO110, GPIO111, GPIO112) that are used by
the kernel, or the 2 "LCD" GPIOs (GPIO22, GPIO73) that are not used?
The SDG code provides no enlightenment.

Paul
