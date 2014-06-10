From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Tue, 10 Jun 2014 13:42:11 +0530
Subject: [PATCH] ARM: EXYNOS: mcpm: Don't rely on firmware's
 secondary_cpu_start
In-Reply-To: <20140609223831.GB16889@e102568-lin.cambridge.arm.com>
References: <1402090985-8061-1-git-send-email-dianders@chromium.org>
 <20140607181221.GB25068@e102568-lin.cambridge.arm.com>
 <CAD=FV=X17PeJ6JPE9Qyc1QT07AvA2PTE69Q87gz9a6MdUHgi4A@mail.gmail.com>
 <20140609223831.GB16889@e102568-lin.cambridge.arm.com>
Message-ID: <CANuQgHHxAhTNYX-JAEdRkO=PMYT4A5GwXcuQfiqwE0CEkQyR+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 June 2014 04:08, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> On Mon, Jun 09, 2014 at 06:03:31PM +0100, Doug Anderson wrote:
>
> [...]
>
>> Cold boot and resume from suspend are detected via various special
>> flags in various special locations.  Resume from suspend looks at
>> INFORM1 (0x10048004) for flags.  This register is 0 during a cold boot
>> and has special values set by the kernel at resume time.
>>
>> It also looks as if some code looks at 0x10040900 (PMU_SPARE0) to help
>> tell initial cold boot and secondary CPU bringup.
>
> Ok, thanks a lot. It looks like firmware paths should be ready to
> detect cold vs warm boot, and hopefully do not rely on a specific
> MPIDR to come up first out of power states.
>
>> > I am asking to check if on this platform CPUidle (where the notion of
>> > primary CPU disappears) has a chance to run properly.
>>
>> I believe it should be possible, but we don't have CPUidle implemented
>> in our current system.  Abhilash may be able to comment more.
>

Cpuidle is implemented for exynos5420, and is tested on chromebook.


> I am interested in more insights, that's very helpful thanks.
>
>> > Probably CPUidle won't attain idle states where IRAM content is lost, but I
>> > am still worried about the primary vs secondaries firmware boot behaviour.
>>
>> I don't think iRAM can be turned off for CPUidle.

Yes thats true.
>
> It might be added a system state but I doubt that too and if you are
> relying on registers for jump addresses that's not even a problem in
> the first place.
>
>> > What happens on reboot from suspend to RAM (or to put it differently,
>> > what does secure firmware do on reboot from suspend to RAM - in
>> > particular how is the "jump" address to bootloader/kernel set ?)
>>
>> Should be described above now.
>
> Thank you very much.
>
> Lorenzo
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
with warm regards,
Chander Kashyap
