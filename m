From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 25 May 2015 16:19:29 +0800
Subject: [PATCH v2 1/2] ARM: imx: enable smp for i.MX7D
In-Reply-To: <1432147961-3547-1-git-send-email-Frank.Li@freescale.com>
References: <1432147961-3547-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20150525081928.GK3264@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 02:52:40AM +0800, Frank.Li at freescale.com wrote:
> From: Frank Li <Frank.Li@freescale.com>
> 
> i.MX7D have two cores.
> enable multicore support.
> enable cpu hotplug support.
> 
> Signed-off-by: Frank Li <Frank.Li@freescale.com>
> Signed-off-by: Anson Huang <b20788@freescale.com>
> ---
> 
> This patch is based on Russel king's
> ARM: v7 setup function should invalidate L1 cache

So we will need to wait for Russell's patch to land on mainline first.

> 
> Change from V1 to V2
>  - base on ARM: v7 setup function should invalidate L1 cache
>  - remove unused define in gpcv2.c
>  - change name imx_gpcv2_set_core1_pdn_pup_by_software to imx_gpcv2_set_core1_power
>  - add timeout check.
>  - Change to BUG_ON
>  - Change use enable-method
> 
>  arch/arm/mach-imx/Kconfig      |  6 ++++
>  arch/arm/mach-imx/Makefile     |  1 +
>  arch/arm/mach-imx/common.h     |  4 +++
>  arch/arm/mach-imx/gpcv2.c      | 67 ++++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-imx/hotplug.c    | 18 ++++++++++++
>  arch/arm/mach-imx/mach-imx7d.c |  1 +
>  arch/arm/mach-imx/platsmp.c    | 18 ++++++++++++
>  arch/arm/mach-imx/src.c        | 35 ++++++++++++++++++++--
>  8 files changed, 147 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/mach-imx/gpcv2.c

Honestly, I do not like the software version numbering which is quite
arbitrary and may conflict with hardware one some day.

More importantly, is i.MX7 GPC block really so different from i.MX6 one
and worth a new driver for it?  If you check the latest GPC driver, you
will find that it evolves a lot recently and becomes a driver handles
not only core power but also PU power domains, and also we have
implemented stacked IRQ domain for it.   Are you going to redo all these
for this gpcv2 driver?

Shawn
