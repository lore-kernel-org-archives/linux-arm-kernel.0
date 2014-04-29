From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Apr 2014 22:36:33 +0200
Subject: [RFC 01/11] drivers: reset: TI: SoC reset controller support.
In-Reply-To: <1398802790-29287-2-git-send-email-dmurphy@ti.com>
References: <1398802790-29287-1-git-send-email-dmurphy@ti.com>
 <1398802790-29287-2-git-send-email-dmurphy@ti.com>
Message-ID: <6639369.9mIUuXImgB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 April 2014 15:19:40 Dan Murphy wrote:
> +#ifndef _RESET_TI_H_
> +#define _RESET_TI_H_
> +
> +#ifdef CONFIG_RESET_TI
> +void ti_dt_reset_init(void);
> +#else
> +static inline void ti_dt_reset_init(void){ return; };
> +#endif

Why can't this be a regular platform device driver that gets
initialized through an initcall rather than get called from
platform code?

	Arnd
