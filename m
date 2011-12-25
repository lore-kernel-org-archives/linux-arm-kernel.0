From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 25 Dec 2011 21:40:32 +0800
Subject: [PATCH v2 11/15] ARM: local timers: switch imx6q to standalone
 smp_twd
In-Reply-To: <1324574865-5367-12-git-send-email-marc.zyngier@arm.com>
References: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
 <1324574865-5367-12-git-send-email-marc.zyngier@arm.com>
Message-ID: <20111225134031.GE8240@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Thu, Dec 22, 2011 at 05:27:41PM +0000, Marc Zyngier wrote:
> Convert the imx6q platforms to the standalone version of smp_twd.c.
> Since the timer calibration code requires another timer to be up
> and running, the actual initialisation is left to the late_timer_init
> hook.
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/mach-imx/Makefile     |    1 -
>  arch/arm/mach-imx/localtimer.c |   35 -----------------------------------
>  arch/arm/mach-imx/mach-imx6q.c |   12 ++++++++++++
>  3 files changed, 12 insertions(+), 36 deletions(-)
>  delete mode 100644 arch/arm/mach-imx/localtimer.c
> 
Are we missing 'select ARM_SMP_TWD' for 'config SOC_IMX6Q' in
arch/arm/mach-imx/Kconfig?

With that added,

Tested-by: Shawn Guo <shawn.guo@linaro.org>

-- 
Regards,
Shawn
