From: charu@ti.com (Varadarajan, Charulatha)
Date: Tue, 26 Apr 2011 18:13:12 +0530
Subject: [PATCH 09/15] OMAP: GPIO: consolidate IRQ status handling,
	remove #ifdefs
In-Reply-To: <1303513327-14532-10-git-send-email-khilman@ti.com>
References: <1303513327-14532-1-git-send-email-khilman@ti.com>
	<1303513327-14532-10-git-send-email-khilman@ti.com>
Message-ID: <BANLkTikqNN0-eW79a6weS_Us1c2WK5MSuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin,

On Sat, Apr 23, 2011 at 04:32, Kevin Hilman <khilman@ti.com> wrote:
> Cleanup IRQ status handling by by passing IRQ status register offsets
> via platform data.

Typo: by by

>
> Cleans up clearing of GPIO IRQ status and GPIO ISR handler.
>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---

<<snip>>

> diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
> index 268bccd..aedd732 100644
> --- a/arch/arm/plat-omap/include/plat/gpio.h
> +++ b/arch/arm/plat-omap/include/plat/gpio.h
> @@ -180,6 +180,8 @@ struct omap_gpio_reg_offs {
> ? ? ? ?u16 dataout;
> ? ? ? ?u16 set_dataout;
> ? ? ? ?u16 clr_dataout;
> + ? ? ? u16 irqstatus;
> + ? ? ? u16 irqstatus2;

Would it be appropriate to name them as (irqstatus1 & irqstatus2)
or (irqstatus & irqstatus1)?

-V Charulatha

> ?};
>
> ?struct omap_gpio_platform_data {
> --
> 1.7.4
>
>
