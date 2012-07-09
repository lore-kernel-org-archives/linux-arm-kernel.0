From: zumeng.chen@windriver.com (Zumeng Chen)
Date: Mon, 9 Jul 2012 12:46:30 +0800
Subject: [PATCH v2 0/2] Watchdog: OMAP: bootstatus fix for omap3 and
 changes for the current watchdog framework
In-Reply-To: <1341808779-25532-1-git-send-email-zumeng.chen@windriver.com>
References: <1341808779-25532-1-git-send-email-zumeng.chen@windriver.com>
Message-ID: <4FFA6226.9010605@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The changes have been validated on omap3530evm

Normal reboot
root at ti-omap3:~# dmesg|grep WDT
omap_wdt: OMAP WDTimer Rev 0x31: Initial timeout 0sec status= 0x0
root at ti-omap3:~#

root at ti-omap3:~# echo 1 >/dev/watchdog
Boot from WDT

root at ti-omap3:~# dmesg|grep WDT
omap_wdt: OMAP WDTimer Rev 0x31: Initial timeout 0sec status= 0x1
root at ti-omap3:~#

Regards,
zumeng
? 2012?07?09? 12:39, Zumeng Chen ??:
> Hello,
>
> The following patches based on the 3.5-rc6 from Wim, which
> are based on:
>
> 1 ) bootstatus fix for omap3,
>
> 2 ) omap-wdt framework update cater for the current framework
>     as Shubhrajyoti comments mentioned.
>
> Regards,
> Zumeng
>
>   Linux 3.5-rc6 (2012-07-07 17:23:56 -0700)
>
> Zumeng Chen (3):
>       Watchdog: Omap: Changes for the new watchdog framework
>       Watchdog: Omap: select watchdog core for framework change
>       Watchdog: Omap: get the bootstatus for OMAP2Plus
>
>  arch/arm/mach-omap2/prcm.c  |    5 +-
>  drivers/watchdog/Kconfig    |    1 +
>  drivers/watchdog/omap_wdt.c |  338 ++++++++++++++++---------------------------
>  drivers/watchdog/omap_wdt.h |    5 +
>  4 files changed, 133 insertions(+), 216 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
