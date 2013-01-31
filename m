From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 31 Jan 2013 16:37:28 +0100
Subject: [PATCH] ARM: OMAP2+: Get rid of custom OMAP_32K_TIMER_HZ
In-Reply-To: <1359646320-9086-1-git-send-email-santosh.shilimkar@ti.com>
References: <1359646320-9086-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1524396.4DaQLsSWOZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 31 January 2013 21:02:00 Santosh Shilimkar wrote:
> The timekeeping doesn't depend on HZ value in presence of fine grained
> clocksource and hence there should not be any time drift because of HZ
> value which was chosen to be divisor of 32768.
> 
> OMAP has been using HZ = 128 value to avoid any time drift issues
> because of 32768 HZ clock. But with various measurements performed
> with HZ = 100, no time drift is observed and it also proves the
> point about HZ not having impact on time keeping on OMAP.
> 
> Very informative thread on this topic is here:
>         https://lkml.org/lkml/2013/1/29/435
> 
> Special thanks to John Stulz, Arnd Bergmann and Russell King for their
> valuable suggestions.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Tony Lindgren <tony@atomide.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks so much for looking into this!
