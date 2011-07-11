From: bryan.wu@canonical.com (Bryan Wu)
Date: Mon, 11 Jul 2011 22:13:29 +0800
Subject: [PATCH 03/17] mach-realview: retire custom LED code
In-Reply-To: <20110710092747.GS4812@n2100.arm.linux.org.uk>
References: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
	<1309955687-19365-4-git-send-email-bryan.wu@canonical.com>
	<20110710092747.GS4812@n2100.arm.linux.org.uk>
Message-ID: <CAK5ve-+Zs=Q9sgfmCYJxOLvV+ATfrjOKrZEH_E49RHPk7WYJEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 10, 2011 at 5:27 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jul 06, 2011 at 08:34:33PM +0800, Bryan Wu wrote:
>> diff --git a/arch/arm/plat-versatile/Kconfig b/arch/arm/plat-versatile/Kconfig
>> index 52353be..c600420 100644
>> --- a/arch/arm/plat-versatile/Kconfig
>> +++ b/arch/arm/plat-versatile/Kconfig
>> @@ -7,8 +7,12 @@ config PLAT_VERSATILE_FPGA_IRQ
>> ? ? ? bool
>>
>> ?config PLAT_VERSATILE_LEDS
>> - ? ? def_bool y if LEDS_CLASS
>> + ? ? def_bool y
>> ? ? ? depends on ARCH_REALVIEW || ARCH_VERSATILE
>> + ? ? select NEW_LEDS
>> + ? ? select LEDS_CLASS
>> + ? ? select LEDS_TRIGGERS
>> + ? ? select LEDS_TRIGGER_CPU
>
> Can you explain the choice to force LED support to be enabled with no
> choice for these?
>

I force to select this to default build-in LEDS stuff and don't wanna
to modify the defconfig to build-in LEDS stuff as default.
Now, I agree we can let users to select them when they wanna to enable
LED via menuconfig.

Thanks,
-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
