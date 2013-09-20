From: yuvaraj.cd@gmail.com (Yuvaraj Kumar)
Date: Fri, 20 Sep 2013 10:27:41 +0530
Subject: [PATCH] ARM: dts: Update arch timer node with clock frequency
In-Reply-To: <20130918102319.GF26737@e106331-lin.cambridge.arm.com>
References: <1379499113-20342-1-git-send-email-yuvaraj.cd@samsung.com>
 <20130918102319.GF26737@e106331-lin.cambridge.arm.com>
Message-ID: <CAKuRcOLfRwJohWMhc=QMew87SXtBmkPUJwW7UzNry_gFuC-81Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resending it as it bounced from kernel mailing group

On Wed, Sep 18, 2013 at 3:53 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> [adding lakml]
>
> On Wed, Sep 18, 2013 at 11:11:53AM +0100, Yuvaraj Kumar C D wrote:
>> Without the "clock-frequency" property in arch timer node, could able
>> to see the below crash dump.
>
> Why does this cause the below crash specifically? What is CNTFRQ reading
> as?
Return value of arch_timer_get_cntfrq() is 0
>
> Your firmware or bootloader should set CNTFRQ -- setting the
> clock-frequency is a work-around for buggy firmware/bootloaders that
> should be avoided as far as possible.
Why kernel should depend on bootloader/firmware  to set CNTFRQ? Any
specific reasons?
Should'nt be indepenedent each other(kernel and bootloader/firmware)?
>
> Is it not possible to fix your firmware or bootlaoder to set CNTFRQ?
>
> Thanks,
> Mark.
>
>>
>> [<c0014e28>] (unwind_backtrace+0x0/0xf4) from [<c0011808>] (show_stack+0x10/0x14)
>> [<c0011808>] (show_stack+0x10/0x14) from [<c036ac1c>] (dump_stack+0x7c/0xb0)
>> [<c036ac1c>] (dump_stack+0x7c/0xb0) from [<c01ab760>] (Ldiv0_64+0x8/0x18)
>> [<c01ab760>] (Ldiv0_64+0x8/0x18) from [<c0062f60>] (clockevents_config.part.2+0x1c/0x74)
>> [<c0062f60>] (clockevents_config.part.2+0x1c/0x74) from [<c0062fd8>] (clockevents_config_and_register+0x20/0x2c)
>> [<c0062fd8>] (clockevents_config_and_register+0x20/0x2c) from [<c02b8e8c>] (arch_timer_setup+0xa8/0x134)
>> [<c02b8e8c>] (arch_timer_setup+0xa8/0x134) from [<c04b47b4>] (arch_timer_init+0x1f4/0x24c)
>> [<c04b47b4>] (arch_timer_init+0x1f4/0x24c) from [<c04b40d8>] (clocksource_of_init+0x34/0x58)
>> [<c04b40d8>] (clocksource_of_init+0x34/0x58) from [<c049ed8c>] (time_init+0x20/0x2c)
>> [<c049ed8c>] (time_init+0x20/0x2c) from [<c049b95c>] (start_kernel+0x1e0/0x39c)
>>
>> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos5250.dtsi |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
>> index 7d7cc77..668ce5d 100644
>> --- a/arch/arm/boot/dts/exynos5250.dtsi
>> +++ b/arch/arm/boot/dts/exynos5250.dtsi
>> @@ -96,6 +96,7 @@
>>                            <1 14 0xf08>,
>>                            <1 11 0xf08>,
>>                            <1 10 0xf08>;
>> +             clock-frequency = <24000000>;
>>       };
>>
>>       mct at 101C0000 {
>> --
>> 1.7.9.5
>>
>>
