From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 28 Aug 2014 17:26:43 -0400
Subject: [PATCH 0/2] IO voltage domain support for rk3188 and rk3288
In-Reply-To: <1409254565-10677-1-git-send-email-dianders@chromium.org>
References: <1409254565-10677-1-git-send-email-dianders@chromium.org>
Message-ID: <53FF9E93.3040601@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 August 2014 03:36 PM, Doug Anderson wrote:
> These two patches add support for automatically configuring the IO
> voltage domains on rk3188 and rk3288 SoCs.  The first patch adds some
> new notification types to the regulator code.  It's used by the second
> patch which actually implements the IO voltage domain driver.
> 
> These two patches were co-developed by Heiko St?bner and Doug Anderson
> (proof of concept patches were written by Heiko).  They were tested in
> a private branch on an rk3288 board using rk808 instead of mainline
> since rk808 support isn't finalized in mainline yet.
> 
> (sorry if you got this series twice; my mailer seems unhappy with me)
> 
> Heiko St?bner (2):
>   regulator: core: Add REGULATOR_EVENT_PRE_VOLTAGE_CHANGE (and ABORT)
>   soc/rockchip: io-domain: add driver handling io domains
> 
Sorry to shot down but your IO domains are nothing but voltage domains
and you should really build something in the drivers/power/*

Please have a look at the RFC [1]. You should really go on those
lines and collaborate to make a generic voltage domain layer instead of throwing
the driver under drivers/soc. 

>  .../devicetree/bindings/arm/rockchip/io-domain.txt |  60 ++++
>  drivers/regulator/core.c                           |  63 +++-
>  drivers/soc/Kconfig                                |   1 +
>  drivers/soc/Makefile                               |   1 +
>  drivers/soc/rockchip/Kconfig                       |  10 +
>  drivers/soc/rockchip/Makefile                      |   1 +
>  drivers/soc/rockchip/io-domain.c                   | 333 +++++++++++++++++++++
>  include/linux/regulator/consumer.h                 |  20 ++
>  8 files changed, 482 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/rockchip/io-domain.txt
>  create mode 100644 drivers/soc/rockchip/Kconfig
>  create mode 100644 drivers/soc/rockchip/Makefile
>  create mode 100644 drivers/soc/rockchip/io-domain.c
> 

Regards,
Santosh
[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/233819.html
