From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sun, 27 Oct 2013 20:24:16 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAyLzRdIHdsMTI1MTogbW92ZSBwb3dlciBHUElPIGhhbmRs?=
 =?UTF-8?B?aW5nIGludG8gdGhlIGRyaXZlcg==?=
In-Reply-To: <1382890469-25286-3-git-send-email-sre@debian.org>
References: <1382890469-25286-1-git-send-email-sre@debian.org>
 <1382890469-25286-3-git-send-email-sre@debian.org>
Message-ID: <1382891056.102746625@f315.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Move the power GPIO handling from the board code into
> the driver. This is a dependency for device tree support.
> 
> Signed-off-by: Sebastian Reichel <sre@debian.org>
> ---
>  arch/arm/mach-omap2/board-omap3pandora.c     |  2 ++
>  arch/arm/mach-omap2/board-rx51-peripherals.c | 11 ++--------
>  drivers/net/wireless/ti/wl1251/sdio.c        | 21 +++++++++++++-----
>  drivers/net/wireless/ti/wl1251/spi.c         | 33 ++++++++++++++++++----------
>  drivers/net/wireless/ti/wl1251/wl1251.h      |  2 +-
>  include/linux/wl12xx.h                       |  2 +-
>  6 files changed, 43 insertions(+), 28 deletions(-)
...
> diff --git a/include/linux/wl12xx.h b/include/linux/wl12xx.h
> index b516b4f..a9c723b 100644
> --- a/include/linux/wl12xx.h
> +++ b/include/linux/wl12xx.h
> @@ -49,7 +49,7 @@ enum {
>  };
>  
>  struct wl1251_platform_data {
> -	void (*set_power)(bool enable);
> +	int power_gpio;
>  	/* SDIO only: IRQ number if WLAN_IRQ line is used, 0 for SDIO IRQs */
>  	int irq;
>  	bool use_eeprom;
> -- 

What a reason for not using regulator API here with GPIO-based regulator?

---
