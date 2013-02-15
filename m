From: sourav.poddar@ti.com (a0131647)
Date: Fri, 15 Feb 2013 18:33:58 +0530
Subject: [RFC/RFT PATCH 0/2] SERIAL: OMAP: Remove idle handling from driver
In-Reply-To: <1360929970-31934-1-git-send-email-santosh.shilimkar@ti.com>
References: <1360929970-31934-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <511E323E.3050104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On Friday 15 February 2013 05:36 PM, Santosh Shilimkar wrote:
> OMAP UART IP needs manual idle modes based on state of the
> IP. Currently this is handled by the driver with function pointers
> implemented in platform code.
>
> This however breaks in case of device tree because of missing
> idle handling.
>
> The series tries to address the issue
>
> Patches has been tested on OMAP4 and OMAP5 devices where the console
> slugishness was observed without idle mode handling. CPUIDLE and
> suspend tested ok on these devices.
>
> Need help in testing on OMAP2, OMAP3 and AM3XXX devices.
>
Tested this series on omap3630 beagle board for:
1. Retention in idle and suspend.
2. Off mode in idle and suspend.

Tested-by: Sourav Poddar <sourav.poddar@ti.com>

> Santosh Shilimkar (2):
>    ARM: OMAP2+: hwmod-data: UART IP needs software control of sidle
>      modes
>    SERIAL: OMAP: Remove the idle handling from the driver
>
>   arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    3 ++
>   arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |    6 ++++
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    4 +++
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    6 +++-
>   arch/arm/mach-omap2/serial.c                       |   31 --------------------
>   drivers/tty/serial/omap-serial.c                   |   23 ---------------
>   6 files changed, 18 insertions(+), 55 deletions(-)
>
