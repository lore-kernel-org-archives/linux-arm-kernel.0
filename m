From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Fri, 21 Sep 2012 11:50:52 +0530
Subject: [PATCH] ARM: OMAP: convert I2C driver to PM QoS for MPU latency
 constraints
In-Reply-To: <1348157283-24119-1-git-send-email-j-pihet@ti.com>
References: <1348157283-24119-1-git-send-email-j-pihet@ti.com>
Message-ID: <CAM=Q2ct+6g1WR-U5e+s=ySAypnkc2SO4kKtDPmTsau+mx1HmbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 9:38 PM, Jean Pihet <jean.pihet@newoldbits.com> wrote:
> Convert the driver from the outdated omap_pm_set_max_mpu_wakeup_lat
> API to the new PM QoS API.
> Since the constraint is on the MPU subsystem, use the PM_QOS_CPU_DMA_LATENCY
> class of PM QoS. The resulting MPU constraints are used by cpuidle to
> decide the next power state of the MPU subsystem.
>
> The I2C device latency timing is derived from the FIFO size and the
> clock speed and so is applicable to all OMAP SoCs.
Agree thanks for doing that.

>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
> Rebased on git://git.pengutronix.de/git/wsa/linux.git, branch
> i2c-embedded/for-next
thanks ,
tested with i2c tools  on omap4sdp and omap3sdp

Acked-by: Shubhrajyoti D <shubhrajyoti@ti.com>

> ---
>  arch/arm/plat-omap/i2c.c      |   21 ---------------------
>  drivers/i2c/busses/i2c-omap.c |   32 ++++++++++++++++++--------------
>  include/linux/i2c-omap.h      |    1 -
>  3 files changed, 18 insertions(+), 36 deletions(-)
>
