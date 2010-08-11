From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 11 Aug 2010 16:27:15 +0800
Subject: [PATCH] fix carelessly written Kconfig select statement
In-Reply-To: <20100811081231.GA21815@n2100.arm.linux.org.uk>
References: <AANLkTinAn_o7+AQzEk7V1vHzCFPPn6AVv=gMqCq7DDdH@mail.gmail.com>
	<20100809073923.GA9838@n2100.arm.linux.org.uk>
	<AANLkTinUq5At6kovGr8jGFOQ9XJJ9+0oXA+b_jsqn_JZ@mail.gmail.com>
	<20100811081231.GA21815@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi==s7SBLJ5QKBDVnnAy9upZqs7VF-6c0o9Mm8MA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 11, 2010 at 4:12 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Aug 11, 2010 at 04:10:45PM +0800, Eric Miao wrote:
>> On Mon, Aug 9, 2010 at 3:39 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Mon, Aug 09, 2010 at 09:50:04AM +0800, eric.y.miao at gmail.com wrote:
>> >> Any one found this?
>> >>
>> >> Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
>> >> ---
>> >> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> >> index 232f0c7..684c1a1 100644
>> >> --- a/arch/arm/Kconfig
>> >> +++ b/arch/arm/Kconfig
>> >> @@ -1184,8 +1184,8 @@ config LOCAL_TIMERS
>> >> ? ? ? ? ? ? ? REALVIEW_EB_A9MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || \
>> >> ? ? ? ? ? ? ? ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || ARCH_TEGRA)
>> >> ? ? ? default y
>> >> - ? ? select HAVE_ARM_TWD if (ARCH_REALVIEW || ARCH_VEXPRESS || ARCH_OMAP4 || \\
>> >> - ? ? ? ? ? ? ARCH_U8500 || ARCH_TEGRA
>> >> + ? ? select HAVE_ARM_TWD if (ARCH_REALVIEW || ARCH_VEXPRESS || ARCH_OMAP4 || \
>> >> + ? ? ? ? ? ? ARCH_U8500 || ARCH_TEGRA)
>> >
>> > Just get rid of the open paren - there's no reason for it to exist.
>> >
>>
>> Updated as below. Patch sent to your tracking system from kernel.org,
>> though not sure if it hits there or not.
>
> 6th patch. :-p
>
> Already fixed in my tree twice over and I'm waiting for Linus to pull it.

Good to know. No problem then.

>
> Thanks anyway.
>
