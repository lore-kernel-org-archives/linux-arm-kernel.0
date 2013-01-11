From: Russ.Dill@ti.com (Russ Dill)
Date: Fri, 11 Jan 2013 00:09:56 -0800
Subject: [PATCH v4 0/4] pm: Add power off control
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EAD58C2@DBDE01.ent.ti.com>
References: <1355464997-19367-1-git-send-email-anilkumar@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EAD58C2@DBDE01.ent.ti.com>
Message-ID: <CA+Bv8XbUa7xPd8V7LQCmFbbdQvORUK1X0xBPzAhKUFFjjho2jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 2, 2013 at 2:15 AM, AnilKumar, Chimata <anilkumar@ti.com> wrote:
> On Fri, Dec 14, 2012 at 11:33:13, AnilKumar, Chimata wrote:
>> Add PM power_off control to rtc driver and PMIC status is set to
>> STATUS_OFF to shutdown PMIC if PWR_EN is toggled by RTC module.
>>
>> System power off sequence:-
>> * Set PMIC STATUS_OFF when PMIC_POWER_EN is pulled low
>> * Enable PMIC_POWER_EN in rtc module
>> * Set rtc ALARM2 time
>> * Enable ALARM2 interrupt
>>
>> These patches were tested on am335x-bone (BeagleBone). These patchs
>> are based on linux-next.
>
> Hi All,
>
> Happy New Year
>
> Gentle ping to this series

I personally like the series, it certainly adds needed functionality.
I just wish there was a way to get it without a possible 4 second
delay.

> Thanks
> AnilKumar
>
>> Changes from v3:
>>       - TPS65217 mfd driver changes are accepted so dropped
>>         from this series.
>>       - With recent changes in the kernel, reboot_mutex held BUG()
>>         is not seen so removed while(1); from rtc_power_off.
>>       - Removed spinlock before while(1); which is not necessary.
>>
>> Changes from v2:
>>       - Incorporated Kevin's comment on v2
>>         * Enabled RTC in ompa2plus_defconfig
>>
>> Changes from v1:
>>       - Incorporated Vaibhav's comments on v1
>>         * Changed the time rollover logic with the help of
>>           rtc-lib APIs
>>
>> AnilKumar Ch (3):
>>   ARM: dts: AM33XX: Set pmic-shutdown-controller for BeagleBone
>>   ARM: dts: AM33XX: Enable system power off control in am335x-bone
>>   ARM: OMAP2+: omap2plus_defconfig: Enable RTC support
>>
>> Colin Foe-Parker (1):
>>   rtc: OMAP: Add system pm_power_off to rtc driver
>>
>>  Documentation/devicetree/bindings/rtc/rtc-omap.txt |    5 ++
>>  arch/arm/boot/dts/am335x-bone.dts                  |    6 ++
>>  arch/arm/configs/omap2plus_defconfig               |    1 +
>>  drivers/rtc/rtc-omap.c                             |   74 +++++++++++++++++++-
>>  4 files changed, 85 insertions(+), 1 deletion(-)
>>
>> --
>> 1.7.9.5
>>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
