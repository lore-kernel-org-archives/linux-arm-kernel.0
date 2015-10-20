From: m.reichl@fivetechno.de (Markus Reichl)
Date: Tue, 20 Oct 2015 15:43:33 +0200
Subject: [PATCH 0/7] Switch to generic syscon regmap based drivers
In-Reply-To: <1445234635-3950-1-git-send-email-alim.akhtar@samsung.com>
References: <1445234635-3950-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <56264505.3090405@fivetechno.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 19.10.2015 um 08:03 schrieb Alim Akhtar:
> Alim Akhtar (7):
>   arm: dts: Add syscon-{reboot, poweroff} nodes for exynos3250 SoCs
>   arm: dts: Add syscon-{reboot, poweroff} nodes for exynos4
>   arm: dts: Add syscon-{reboot, poweroff} nodes for exynos5
>   arm: dts: Add syscon-{reboot, poweroff} nodes for exynos5410 SoC
>   ARM: exynos_defconfig: Normalize exynos defconfig
>   ARM: exynos_defconfig: Enable generic syscon-{reboot, poweroff}
>     drivers
>   ARM: EXYNOS: Remove code for restart and poweroff for exynos SoCs
> 
>  arch/arm/boot/dts/exynos3250.dtsi |   14 ++++++++++++
>  arch/arm/boot/dts/exynos4.dtsi    |   14 ++++++++++++
>  arch/arm/boot/dts/exynos5.dtsi    |   14 ++++++++++++
>  arch/arm/boot/dts/exynos5410.dtsi |   14 ++++++++++++
>  arch/arm/configs/exynos_defconfig |   11 +++++-----
>  arch/arm/mach-exynos/pmu.c        |   43 -------------------------------------
>  6 files changed, 61 insertions(+), 49 deletions(-)
> 
Hi,

I have tested this patch on my Odroid U3 and U3+ using 4.3.0-rc6 from
Tobias' repo at https://github.com/tobiasjakobi/linux-odroid/tree/odroid-4.3.y

and his debug config:
https://raw.githubusercontent.com/tobiasjakobi/odroid-environment/master/sourcecode/system/vanilla-4.3-debug.conf

halt -p works (power goes down to 0W)

reboot does not work, stuck at 0.5W, right after
"systemd-shutdown[1]: rebooting".

reboot did work with 4.3.0-rc3 from above repo (without Alim's patch).

Thanks,
-- 
Markus Reichl
