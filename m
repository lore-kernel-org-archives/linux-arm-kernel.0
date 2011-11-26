From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sat, 26 Nov 2011 12:45:23 +0800
Subject: [PATCH 6/7] ARM: pxa: enable pinmux mapping in zylonite
In-Reply-To: <201111260353.36899.arnd@arndb.de>
References: <1322262544-7854-1-git-send-email-haojian.zhuang@marvell.com>
 <1322262544-7854-7-git-send-email-haojian.zhuang@marvell.com>
 <201111260353.36899.arnd@arndb.de>
Message-ID: <CAN1soZyG-mxEGBWJZMt-MeWthXu0B6Zs34Fik9t+OOR4MZ=EKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 26, 2011 at 11:53 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 25 November 2011, Haojian Zhuang wrote:
>> Remove MFP operation in zylonite. Use pinmux mapping instead.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>> ---
>> ?arch/arm/mach-pxa/Kconfig ? ? ? ? ? ? ? ? | ? ?1 +
>> ?arch/arm/mach-pxa/devices.c ? ? ? ? ? ? ? | ? 15 ++
>> ?arch/arm/mach-pxa/devices.h ? ? ? ? ? ? ? | ? ?1 +
>> ?arch/arm/mach-pxa/include/mach/zylonite.h | ? ?2 +
>> ?arch/arm/mach-pxa/pxa3xx.c ? ? ? ? ? ? ? ?| ? ?1 +
>> ?arch/arm/mach-pxa/zylonite.c ? ? ? ? ? ? ?| ? ?6 +
>> ?arch/arm/mach-pxa/zylonite_pxa300.c ? ? ? | ?298 +++++++++++------------------
>> ?arch/arm/mach-pxa/zylonite_pxa320.c ? ? ? | ?211 +++++----------------
>> ?8 files changed, 183 insertions(+), 352 deletions(-)
>
>
>> ? ? ? ? ? ? ? /* GPIO pin assignment */
>> - ? ? ? ? ? ? gpio_eth_irq ? ?= mfp_to_gpio(MFP_PIN_GPIO9);
>> + ? ? ? ? ? ? gpio_eth_irq ? ?= 90;
>> +#if 0
>> + ? ? ? ? ? ? /* FIXME: can't support additional gpio pins */
>> ? ? ? ? ? ? ? gpio_debug_led1 = mfp_to_gpio(MFP_PIN_GPIO1_2);
>> ? ? ? ? ? ? ? gpio_debug_led2 = mfp_to_gpio(MFP_PIN_GPIO4_2);
>> +#endif
>
> If I read this correctly, your comment here refers to a different aspect of the
> same problem, not being able to amend the mapping at a later point.
>
GPIO1, GPIO4, GPIO1_2, GPIO4_2 are four pads. Both GPIO1 and GPIO1_2
can be configured as GPIO1. It's same on GPIO4/GPIO4/2.

At here, we need to configure GPIO1_2 as GPIO1. It also means that we
need set GPIO1 as not gpio function automatically. In current pinmux
driver, one GPIO can only be routed to one pad. Now I don't have good
ideas on how to resolve this. Any comments are welcome.

Best Regards
Haojian
