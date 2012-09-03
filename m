From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 3 Sep 2012 16:17:05 +0200
Subject: [PATCH] ARM: ux500: Fix build error due to missing include of
 asm/pmu.h in cpu-db8500.c
In-Reply-To: <20120903133839.GC31542@mudshark.cambridge.arm.com>
References: <1346588747.7909.2.camel@phoenix>
 <CACRpkdYxYGa=C092rbTU5bo=YEu6wqiTUD7W4pLS_wNfmAe4Zw@mail.gmail.com>
 <20120903133839.GC31542@mudshark.cambridge.arm.com>
Message-ID: <CACRpkdZ-13VkqdLx97gRDOkGO8m=zrxMeVVFbHvRoYoZnkVeEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 3, 2012 at 3:38 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Sep 03, 2012 at 11:47:51AM +0100, Linus Walleij wrote:
>> On Sun, Sep 2, 2012 at 2:25 PM, Axel Lin <axel.lin@gmail.com> wrote:
>>
>> > Include asm/pmu.h to fix below build error:
>> >
>> >   CC      arch/arm/mach-ux500/cpu-db8500.o
>> > arch/arm/mach-ux500/cpu-db8500.c:118:8: error: variable 'db8500_pmu_platdata' has initializer but incomplete type
>> > arch/arm/mach-ux500/cpu-db8500.c:119:2: error: unknown field 'handle_irq' specified in initializer
>> > arch/arm/mach-ux500/cpu-db8500.c:119:2: warning: excess elements in struct initializer [enabled by default]
>> > arch/arm/mach-ux500/cpu-db8500.c:119:2: warning: (near initialization for 'db8500_pmu_platdata') [enabled by default]
>> > make[1]: *** [arch/arm/mach-ux500/cpu-db8500.o] Error 1
>> > make: *** [arch/arm/mach-ux500] Error 2
>> >
>> > Signed-off-by: Axel Lin <axel.lin@gmail.com>
>>
>> That's on linux-next not on v3.6-rcN right?
>>
>> I've applied it to my ux500 branch and will carry it unless Will Deacon
>> express an interest in it, PMU is his territory...
>
> I've already sent a pull for those patches, so please can you carry the
> fixup? u8500 is the only platform using the arm_pmu_platdata at the moment
> so it has to keep the include.

OK I'll take it...

Yours,
Linus Walleij
