From: tony@atomide.com (Tony Lindgren)
Date: Fri, 13 Mar 2015 08:13:02 -0700
Subject: [PATCH v6 6/6] wlcore: remove wl12xx_platform_data
In-Reply-To: <1426162154-8716-7-git-send-email-eliad@wizery.com>
References: <1426162154-8716-1-git-send-email-eliad@wizery.com>
 <1426162154-8716-7-git-send-email-eliad@wizery.com>
Message-ID: <20150313151301.GJ5264@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Eliad Peller <eliad@wizery.com> [150312 05:10]:
> Now that we have wlcore device-tree bindings in place
> (for both wl12xx and wl18xx), remove the legacy
> wl12xx_platform_data struct, and move its members
> into the platform device data (that is passed to wlcore)
> 
> Davinci 850 is the only platform that still set
> the platform data in the legacy way (and doesn't
> have DT bindings), so remove the relevant
> code/Kconfig option from the board file (as suggested
> by Sekhar Nori)
> 
> Signed-off-by: Luciano Coelho <luca@coelho.fi>
> Signed-off-by: Eliad Peller <eliad@wizery.com>
> ---
>  arch/arm/mach-davinci/Kconfig                  |  11 ---
>  arch/arm/mach-davinci/board-da850-evm.c        | 113 -------------------------
>  drivers/net/wireless/ti/wilink_platform_data.c |  25 ------
>  drivers/net/wireless/ti/wl12xx/main.c          |  19 ++---
>  drivers/net/wireless/ti/wlcore/boot.c          |   1 -
>  drivers/net/wireless/ti/wlcore/main.c          |   4 +-
>  drivers/net/wireless/ti/wlcore/sdio.c          |  75 +++++-----------
>  drivers/net/wireless/ti/wlcore/wlcore_i.h      |   8 +-
>  include/linux/wl12xx.h                         |  25 ------
>  9 files changed, 36 insertions(+), 245 deletions(-)

I got a build error related to the SPI driver with this series, probably
need to update this patch:

drivers/net/wireless/ti/wlcore/spi.c: In function ?wl1271_probe?:
drivers/net/wireless/ti/wlcore/spi.c:334:11: error: ?struct wlcore_platdev_data? has no member named ?pdata?
  pdev_data.pdata = dev_get_platdata(&spi->dev);
           ^
drivers/net/wireless/ti/wlcore/spi.c:335:16: error: ?struct wlcore_platdev_data? has no member named ?pdata?
  if (!pdev_data.pdata) {

Regards,

Tony
