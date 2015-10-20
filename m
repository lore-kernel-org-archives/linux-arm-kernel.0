From: alim.akhtar@gmail.com (Alim Akhtar)
Date: Tue, 20 Oct 2015 21:22:05 +0530
Subject: [PATCH v2 0/6] Switch to generic syscon regmap based drivers
In-Reply-To: <CAGOxZ50G-ttivhVjbozUisA0HXcFz7bvRUuPR67xR88TTCa_wQ@mail.gmail.com>
References: <1445333085-22837-1-git-send-email-alim.akhtar@samsung.com>
 <562656D4.1040403@fivetechno.de>
 <CAGOxZ50G-ttivhVjbozUisA0HXcFz7bvRUuPR67xR88TTCa_wQ@mail.gmail.com>
Message-ID: <CAGOxZ51_JPy51htzD_M_=qaPVUexkVhoA2ANLS2-rpK3QDT=8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 20, 2015 at 9:17 PM, Alim Akhtar <alim.akhtar@gmail.com> wrote:
> Hi Markus,
>
> On Tue, Oct 20, 2015 at 8:29 PM, Markus Reichl <m.reichl@fivetechno.de> wrote:
>> Am 20.10.2015 um 11:24 schrieb Alim Akhtar:
>>> Now we have a nice way to reboot/poweroff system using a generic
>>> syscon regmap based drivers, this series moves exynos SoCs to
>>> make use of the same.
>>>
>>> Changes since v1:
>>> * Added a comment about the register information
>>> * Droped defconfig changes as disscussed
>>> * Collected various Reviewed-by, Tested-by and Acked-by tags
>>> * Added SYSCON-{RESET, POWEROFF} to select from Kconfig
>>>
>>> Alim Akhtar (6):
>>>   arm: dts: Add syscon-{reboot, poweroff} nodes for exynos3250 SoCs
>>>   arm: dts: Add syscon-{reboot, poweroff} nodes for exynos4
>>>   arm: dts: Add syscon-{reboot, poweroff} nodes for exynos5
>>>   arm: dts: Add syscon-{reboot, poweroff} nodes for exynos5410 SoC
>>>   ARM: exynos: select POWER_RESET_SYSCON and
>>>     POWER_RESET_SYSCON_POWEROFF
>>>   ARM: EXYNOS: Remove code for restart and poweroff for exynos SoCs
>>>
>>>  arch/arm/boot/dts/exynos3250.dtsi |   14 ++++++++++++
>>>  arch/arm/boot/dts/exynos4.dtsi    |   14 ++++++++++++
>>>  arch/arm/boot/dts/exynos5.dtsi    |   14 ++++++++++++
>>>  arch/arm/boot/dts/exynos5410.dtsi |   14 ++++++++++++
>>>  arch/arm/mach-exynos/Kconfig      |    3 +++
>>>  arch/arm/mach-exynos/pmu.c        |   43 -------------------------------------
>>>  6 files changed, 59 insertions(+), 43 deletions(-)
>>>
>>
>> Hi Alim,
>>
>> I have installed your patch set above with git am on top of
>> 4.3.0-rc6-00108-gce1fad2 torvalds/linux of today
>> with make exynos_defconfig on Odroid U3.
>>
> which exynos soc Odroid U3 uses?
>
OK, I can see its uses exynos4412 and exynos4412-odroidu3.dts does
include exynos4.dtsi,
so these should have worked.

>> "halt -p" worked (power 0.0W).
>> "reboot" got stuck at 0.5W.
>>
> reboot stuck mean system does not reboot any more?
> As far as I can see there in __no__ functional changes that my patch introduce.
> So ideally it should have work. My patches are based on the top on
> vanilla v4.3-rc5.
> (25cb62b Linux 4.3-rc5), can you check at this commit?
>
> Will check with the commit mentioned by you tomorrow.
>
>>
>> Without your patch set reboot worked.
>>
>>
>> Thanks,
>> --
>> Markus Reichl
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Regards,
> Alim



-- 
Regards,
Alim
