From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 09 Dec 2010 08:56:20 -0800
Subject: [PATCH v2 0/2] OMAP: I2C and UART device name cleanup
In-Reply-To: <1291904657-32729-1-git-send-email-b-cousson@ti.com> (Benoit
	Cousson's message of "Thu, 9 Dec 2010 15:24:15 +0100")
References: <1291904657-32729-1-git-send-email-b-cousson@ti.com>
Message-ID: <874oamdgwb.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Benoit Cousson <b-cousson@ti.com> writes:

> Hi All,
>
> In order to enforce a little bit of consistency in the omap devices name,
> the convention for omap devices name will be now omap_xxx. All the drivers
> adapted to hwmod will be named like that during the on-going adaptations.
>
> The I2C and UART drivers are already adapted to hwmod but with
> the originals name.
>
> Rename i2c and uart using this convention:
> i2c_omap -> omap_i2c
> omap-hsuart -> omap_uart
>
> Tested on OMAP4 ES2 on Panda / sdp4430. Some more validation will be needed on OMAP2 & 3.
>
> This series is based on Kevin's pm-hwmod-i2c branch and is available here:
> git://gitorious.org/omap-pm/linux.git for_2.6.38/device_name

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

> Regards,
> Benoit
>
>
> v1
>     http://www.spinics.net/lists/linux-omap/msg41474.html
>     
>     Merge previous patch #1 and #2 as suggested by Kevin to change the driver name 
>     at the same time with the device name in the clockdev.
>
>
> Benoit Cousson (2):
>   I2C: i2c-omap: Change device name: i2c_omap -> omap_i2c
>   OMAP: serial: Change device name: omap-hsuart -> omap_uart
>
>  arch/arm/mach-omap1/clock_data.c              |    6 +++---
>  arch/arm/mach-omap2/clock2420_data.c          |    8 ++++----
>  arch/arm/mach-omap2/clock2430_data.c          |    8 ++++----
>  arch/arm/mach-omap2/clock3xxx_data.c          |   12 ++++++------
>  arch/arm/mach-omap2/clock44xx_data.c          |   16 ++++++++--------
>  arch/arm/plat-omap/i2c.c                      |    2 +-
>  arch/arm/plat-omap/include/plat/omap-serial.h |    2 +-
>  drivers/i2c/busses/i2c-omap.c                 |    4 ++--
>  8 files changed, 29 insertions(+), 29 deletions(-)
