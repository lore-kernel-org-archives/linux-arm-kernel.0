From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 20 Oct 2015 22:56:46 +0900
Subject: [PATCH 0/7] Switch to generic syscon regmap based drivers
In-Reply-To: <56264505.3090405@fivetechno.de>
References: <1445234635-3950-1-git-send-email-alim.akhtar@samsung.com>
 <56264505.3090405@fivetechno.de>
Message-ID: <CAJKOXPd74=CuUP_ue=ZqPFX6HbMu9qBCTYtNU+KZ1X4Dvs2ZGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-10-20 22:43 GMT+09:00 Markus Reichl <m.reichl@fivetechno.de>:
> Am 19.10.2015 um 08:03 schrieb Alim Akhtar:
>> Alim Akhtar (7):
>>   arm: dts: Add syscon-{reboot, poweroff} nodes for exynos3250 SoCs
>>   arm: dts: Add syscon-{reboot, poweroff} nodes for exynos4
>>   arm: dts: Add syscon-{reboot, poweroff} nodes for exynos5
>>   arm: dts: Add syscon-{reboot, poweroff} nodes for exynos5410 SoC
>>   ARM: exynos_defconfig: Normalize exynos defconfig
>>   ARM: exynos_defconfig: Enable generic syscon-{reboot, poweroff}
>>     drivers
>>   ARM: EXYNOS: Remove code for restart and poweroff for exynos SoCs
>>
>>  arch/arm/boot/dts/exynos3250.dtsi |   14 ++++++++++++
>>  arch/arm/boot/dts/exynos4.dtsi    |   14 ++++++++++++
>>  arch/arm/boot/dts/exynos5.dtsi    |   14 ++++++++++++
>>  arch/arm/boot/dts/exynos5410.dtsi |   14 ++++++++++++
>>  arch/arm/configs/exynos_defconfig |   11 +++++-----
>>  arch/arm/mach-exynos/pmu.c        |   43 -------------------------------------
>>  6 files changed, 61 insertions(+), 49 deletions(-)
>>
> Hi,
>
> I have tested this patch on my Odroid U3 and U3+ using 4.3.0-rc6 from
> Tobias' repo at https://github.com/tobiasjakobi/linux-odroid/tree/odroid-4.3.y
>
> and his debug config:
> https://raw.githubusercontent.com/tobiasjakobi/odroid-environment/master/sourcecode/system/vanilla-4.3-debug.conf
>
> halt -p works (power goes down to 0W)
>
> reboot does not work, stuck at 0.5W, right after
> "systemd-shutdown[1]: rebooting".
>
> reboot did work with 4.3.0-rc3 from above repo (without Alim's patch).

Hi Markus,

You replied to v1 so I assume you tested v1. Please test latest version: v2.

Mentioned Tobias' repo does not look like vanilla 4.3.0-rc6. Because
of that it may contain additional patches which can fix something...
or break something (like the reboot).
Please test it on latest mainline release or some recent linux-next.

In my case I tested it on linux-next on Oroid XU3 and tomorrow I will
give it a try on Trats2.

Best regards,
Krzysztof
