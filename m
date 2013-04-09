From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Apr 2013 11:32:01 +0200
Subject: linux-next: manual merge of the arm-soc tree with the omap_dss2
 tree
In-Reply-To: <20130409174047.c506479e08e9688c0a4ced9a@canb.auug.org.au>
References: <20130409174047.c506479e08e9688c0a4ced9a@canb.auug.org.au>
Message-ID: <201304091132.01771.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 April 2013, Stephen Rothwell wrote:
> 
> - #if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91x_MODULE)
>  -static void __init sdp2430_display_init(void)
>  -{
>  -      int r;
>  -
>  -      static struct gpio gpios[] __initdata = {
>  -              { SDP2430_LCD_PANEL_ENABLE_GPIO, GPIOF_OUT_INIT_LOW,
>  -                      "LCD reset" },
>  -              { SDP2430_LCD_PANEL_BACKLIGHT_GPIO, GPIOF_OUT_INIT_LOW,
>  -                      "LCD Backlight" },
>  -      };
>  -
>  -      r = gpio_request_array(gpios, ARRAY_SIZE(gpios));
>  -      if (r) {
>  -              pr_err("Cannot request LCD GPIOs, error %d\n", r);
>  -              return;
>  -      }
>  -
>  -      omap_display_init(&sdp2430_dss_data);
>  -}
>  -
> + #if IS_ENABLED(CONFIG_SMC91X)

Looks good, thanks!

	Arnd
