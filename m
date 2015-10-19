From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Mon, 19 Oct 2015 13:10:14 +0530
Subject: [PATCH 0/7] Switch to generic syscon regmap based drivers
In-Reply-To: <562493BF.9080301@samsung.com>
References: <1445234635-3950-1-git-send-email-alim.akhtar@samsung.com>
 <562493BF.9080301@samsung.com>
Message-ID: <56249E5E.80405@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/19/2015 12:24 PM, Krzysztof Kozlowski wrote:
> On 19.10.2015 15:03, Alim Akhtar wrote:
> ...
>
> Hi,
>
> I am happy to see more contributions from your side! Keep it up. :)
>
Thank you! will keep finding time and doing it.

> However this empty space in your cover letter is the place for
> description of the patchset. What do you want to achieve here? What kind
> of problem are you solving? What features are you adding? Any dependencies?
>
Ah, my bad, I used --compose option with git-send-email and did composed 
the message, somehow it got missed. Will take care.

The motivation came when I tried to used reboot/poweroff on exynos7, and 
since exynos7 has not added/enabled PMU and does not have access to 
arch/arm/mach-exynos, so option are to have a reboot/restart driver or 
we move pmu.c out of mach-exynos. I know there where some effort in past 
to move pmu.c to drivers, but I feel that is still WIP.
And then I came across this generic syscon regmap based driver which are 
already in place, so just used it.
Hope that helps.

> Best regards,
> Krzysztof
>
>> Alim Akhtar (7):
>>    arm: dts: Add syscon-{reboot, poweroff} nodes for exynos3250 SoCs
>>    arm: dts: Add syscon-{reboot, poweroff} nodes for exynos4
>>    arm: dts: Add syscon-{reboot, poweroff} nodes for exynos5
>>    arm: dts: Add syscon-{reboot, poweroff} nodes for exynos5410 SoC
>>    ARM: exynos_defconfig: Normalize exynos defconfig
>>    ARM: exynos_defconfig: Enable generic syscon-{reboot, poweroff}
>>      drivers
>>    ARM: EXYNOS: Remove code for restart and poweroff for exynos SoCs
>>
>>   arch/arm/boot/dts/exynos3250.dtsi |   14 ++++++++++++
>>   arch/arm/boot/dts/exynos4.dtsi    |   14 ++++++++++++
>>   arch/arm/boot/dts/exynos5.dtsi    |   14 ++++++++++++
>>   arch/arm/boot/dts/exynos5410.dtsi |   14 ++++++++++++
>>   arch/arm/configs/exynos_defconfig |   11 +++++-----
>>   arch/arm/mach-exynos/pmu.c        |   43 -------------------------------------
>>   6 files changed, 61 insertions(+), 49 deletions(-)
>>
>
>
