From: kyungmin.park@samsung.com (Kyungmin Park)
Date: Wed, 23 Jun 2010 22:36:54 +0900
Subject: [PATCH v2 0/4] ARM: S5P: Support gpio interrupts
In-Reply-To: <004601cb12a8$c869e560$593db020$%kim@samsung.com>
References: <4C11F4CA.10802@samsung.com>
	<004601cb12a8$c869e560$593db020$%kim@samsung.com>
Message-ID: <AANLkTilGbh8F-LzBhbB-q8h6bcrFPHlFSriuDo_WXKMB@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 23, 2010 at 4:50 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Joonyoung Shim wrote:
>>
>> This patch v2 set is to support gpio interrupts of samsung s5p cpus, and
>> the GPIOlib gpio_to_irq goes to plat-samsung gpiolib, so patch v2 set
>> has four commit smaller than v1.
>>
>> Changes since v1:
>> - Add irq_base to s3c_gpio_chip struct
>> - GPIOlib gpio_to_irq() is implemented to samsung_gpiolib_to_irq() of
>> ? plat-samsung gpiolib
>>
>> Joonyoung Shim (4):
>> ? ? ? ARM: S5PV210: Add gpio interrupt support
>> ? ? ? ARM: S5PC100: Use S5P gpio interrupts interface
>> ? ? ? ARM: S5PC100: Move external interrupt defines
>> ? ? ? ARM: SAMSUNG: Add GPIOlib gpio_to_irq
>>
>> ?arch/arm/mach-s5pc100/Makefile ? ? ? ? ? ? ? ? | ? ?2 +-
>> ?arch/arm/mach-s5pc100/gpiolib.c ? ? ? ? ? ? ? ?| ? 70 ++-----
>> ?arch/arm/mach-s5pc100/include/mach/gpio.h ? ? ?| ? ?7 -
>> ?arch/arm/mach-s5pc100/include/mach/irqs.h ? ? ?| ? 18 ++-
>> ?arch/arm/mach-s5pc100/include/mach/regs-gpio.h | ? ?7 +
>> ?arch/arm/mach-s5pc100/irq-gpio.c ? ? ? ? ? ? ? | ?266
> ------------------------
>> ?arch/arm/mach-s5pv210/gpiolib.c ? ? ? ? ? ? ? ?| ? 18 ++-
>> ?arch/arm/mach-s5pv210/include/mach/irqs.h ? ? ?| ? 16 ++-
>> ?arch/arm/plat-s5p/Makefile ? ? ? ? ? ? ? ? ? ? | ? ?2 +-
>> ?arch/arm/plat-s5p/irq-gpioint.c ? ? ? ? ? ? ? ?| ?208 ++++++++++++++++++
>> ?arch/arm/plat-samsung/gpiolib.c ? ? ? ? ? ? ? ?| ? ?9 +
>> ?arch/arm/plat-samsung/include/plat/gpio-core.h | ? ?6 +
>> ?12 files changed, 295 insertions(+), 334 deletions(-)
>> ?delete mode 100644 arch/arm/mach-s5pc100/irq-gpio.c
>> ?create mode 100644 arch/arm/plat-s5p/irq-gpioint.c
>>
>
> I am sure this patchset is working code, but Ben had made suggestion about
> 'sparse irq'...
> It is because there are too many gpio interrupts and having support of all
> of them is unnecessary as realistically only few of them maybe used.
> In fact in SMDK board there is no use of gpio in interrupt mode.
>
> Ben, I remember your suggestion for using 'sparse irq' for handling gpio
> interrupts.
> And in fact, sparse irq implementation can be beneficial to many other
> boards...
> Could you please explain about that?
Interesting.
you can find it by "[ARM] Preliminary support for dynamic IRQ" written by Eric.
Instead define the 'NR_IRQS' of chip, board can define each 'nr_irqs'
at init time.

Maybe smdk don't use the GPIOs. but mobile phones at samsung use the until MP0x.
Sometime H/W team connect it at MP04 or MP05 which doesn't support
GPIO interrupt.

Thank you,
Kyungmin Park
