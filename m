From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Fri, 24 Feb 2012 15:53:58 +0400
Subject: [PATCH 4/7] ARM: OMAP2+: Fix zoom LCD backlight if TWL_CORE is
 not selected
In-Reply-To: <20120224005411.16794.720.stgit@kaulin.local>
References: <20120224005324.16794.73852.stgit@kaulin.local>
 <20120224005411.16794.720.stgit@kaulin.local>
Message-ID: <4F477A56.9000005@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 24-02-2012 4:54, Tony Lindgren wrote:

> Otherwise we get:

> arch/arm/mach-omap2/board-zoom-display.c:64: undefined reference to `twl_i2c_read_u8'
> arch/arm/mach-omap2/board-zoom-display.c:65: undefined reference to `twl_i2c_read_u8'
> arch/arm/mach-omap2/board-zoom-display.c:84: undefined reference to `twl_i2c_write_u8'
> arch/arm/mach-omap2/board-zoom-display.c:86: undefined reference to `twl_i2c_write_u8'
> arch/arm/mach-omap2/board-zoom-display.c:91: undefined reference to `twl_i2c_write_u8'
> arch/arm/mach-omap2/board-zoom-display.c:92: undefined reference to `twl_i2c_write_u8'
> arch/arm/mach-omap2/board-zoom-display.c:72: undefined reference to `twl_i2c_write_u8'

> Signed-off-by: Tony Lindgren<tony@atomide.com>
[...]

> diff --git a/arch/arm/mach-omap2/board-zoom-display.c b/arch/arm/mach-omap2/board-zoom-display.c
> index d4683ba..7f75fcd 100644
> --- a/arch/arm/mach-omap2/board-zoom-display.c
> +++ b/arch/arm/mach-omap2/board-zoom-display.c
> @@ -53,8 +53,11 @@ static void zoom_panel_disable_lcd(struct omap_dss_device *dssdev)
>   #define TWL_LED_PWMON	0x0
>   #define TWL_LED_PWMOFF	0x1
>
> +
>   static int zoom_set_bl_intensity(struct omap_dss_device *dssdev, int level)
>   {
> +

    Empty lines not needed.

> +#ifdef CONFIG_TWL4030_CORE
>   	unsigned char c;
>   	u8 mux_pwm, enb_pwm;
>

WBR, Sergei
