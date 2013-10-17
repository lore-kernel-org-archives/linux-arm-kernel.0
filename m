From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 17 Oct 2013 12:28:35 +0300
Subject: [PATCH 0/2] OMAP4460: cpuidle: Workaround for ROM bug because
 of CA9 r2pX GIC control register change
In-Reply-To: <525FACA9.3060405@ti.com>
References: <1382000776-15897-1-git-send-email-grygorii.strashko@ti.com>
 <525FACA9.3060405@ti.com>
Message-ID: <525FADC3.4090505@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, forgot to mention that patches are based on 4a10c2a Linux 3.12-rc2

On 10/17/2013 12:23 PM, Grygorii Strashko wrote:
> The same workaround as ff999b8a0983ee15668394ed49e38d3568fc6859
> "ARM: OMAP4460: Workaround for ROM bug because of CA9 r2pX GIC control register change."
> need to be applied not only when system is booting, but when
> MPU hits OSWR state through CPUIdle too.
>
> Now the same issue is reproduced on boards PandaES and Tablet/Blaze with
> SOM OMAP4460 ES1.0 when CONFIG_CPU_IDLE is enabled.
> - GIC distributor is disabled
> - scheduling is not performed any more
>
> Grygorii Strashko (2):
>    Revert "ARM: OMAP4+: CPUidle: Deprecate use of omap4_mpuss_read_prev_context_state()"
>    ARM: OMAP4460: cpuidle: WA for ROM bug because of CA9 r2pX gic control register change
>
>   arch/arm/mach-omap2/common.h              |    6 +++++
>   arch/arm/mach-omap2/cpuidle44xx.c         |   35 +++++++++++++++++++++++++++--
>   arch/arm/mach-omap2/omap-mpuss-lowpower.c |   14 ++++++++++++
>   arch/arm/mach-omap2/omap4-common.c        |    6 +++++
>   4 files changed, 59 insertions(+), 2 deletions(-)
>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@linaro.org>
>
> Regards,
> -grygorii
>
