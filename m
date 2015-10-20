From: m.reichl@fivetechno.de (Markus Reichl)
Date: Tue, 20 Oct 2015 16:59:32 +0200
Subject: [PATCH v2 0/6] Switch to generic syscon regmap based drivers
In-Reply-To: <1445333085-22837-1-git-send-email-alim.akhtar@samsung.com>
References: <1445333085-22837-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <562656D4.1040403@fivetechno.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 20.10.2015 um 11:24 schrieb Alim Akhtar:
> Now we have a nice way to reboot/poweroff system using a generic
> syscon regmap based drivers, this series moves exynos SoCs to
> make use of the same.
> 
> Changes since v1:
> * Added a comment about the register information
> * Droped defconfig changes as disscussed
> * Collected various Reviewed-by, Tested-by and Acked-by tags
> * Added SYSCON-{RESET, POWEROFF} to select from Kconfig
> 
> Alim Akhtar (6):
>   arm: dts: Add syscon-{reboot, poweroff} nodes for exynos3250 SoCs
>   arm: dts: Add syscon-{reboot, poweroff} nodes for exynos4
>   arm: dts: Add syscon-{reboot, poweroff} nodes for exynos5
>   arm: dts: Add syscon-{reboot, poweroff} nodes for exynos5410 SoC
>   ARM: exynos: select POWER_RESET_SYSCON and
>     POWER_RESET_SYSCON_POWEROFF
>   ARM: EXYNOS: Remove code for restart and poweroff for exynos SoCs
> 
>  arch/arm/boot/dts/exynos3250.dtsi |   14 ++++++++++++
>  arch/arm/boot/dts/exynos4.dtsi    |   14 ++++++++++++
>  arch/arm/boot/dts/exynos5.dtsi    |   14 ++++++++++++
>  arch/arm/boot/dts/exynos5410.dtsi |   14 ++++++++++++
>  arch/arm/mach-exynos/Kconfig      |    3 +++
>  arch/arm/mach-exynos/pmu.c        |   43 -------------------------------------
>  6 files changed, 59 insertions(+), 43 deletions(-)
> 

Hi Alim,

I have installed your patch set above with git am on top of 
4.3.0-rc6-00108-gce1fad2 torvalds/linux of today 
with make exynos_defconfig on Odroid U3.

"halt -p" worked (power 0.0W).
"reboot" got stuck at 0.5W.


Without your patch set reboot worked.  


Thanks,
-- 
Markus Reichl
