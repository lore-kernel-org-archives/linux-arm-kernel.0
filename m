From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 12 Mar 2012 09:52:10 +0530
Subject: [PATCH 3/5] ARM: Exynos4: Add pinctrl devices and pin maps
In-Reply-To: <4F5D1661.4090007@samsung.com>
References: <1331469965-28846-1-git-send-email-thomas.abraham@linaro.org>
 <1331469965-28846-4-git-send-email-thomas.abraham@linaro.org>
 <4F5D1661.4090007@samsung.com>
Message-ID: <CAJuYYwQPrOte4EjpfBbUW0vg+qFJwYgZcSM88iZ95C8LwWuptg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/3/12 Kukjin Kim <kgene.kim@samsung.com>:
> Thomas Abraham wrote:
>> Add the three pinctrl platform devices and the pin maps for Exynos4.
>>
>> Signed-off-by: Thomas Abraham<thomas.abraham@linaro.org>
>> ---
>> ? arch/arm/mach-exynos/Kconfig ? ? ? ? ? ? ?| ? ?1 +
>> ? arch/arm/mach-exynos/Makefile ? ? ? ? ? ? | ? ?1 +
>> ? arch/arm/mach-exynos/common.h ? ? ? ? ? ? | ? ?6 ++
>> ? arch/arm/mach-exynos/dev-pinctrl.c ? ? ? ?| ?115 +++++++++++++++++++++++++++++
>> ? arch/arm/plat-samsung/include/plat/devs.h | ? ?3 +
>> ? 5 files changed, 126 insertions(+), 0 deletions(-)
>> ? create mode 100644 arch/arm/mach-exynos/dev-pinctrl.c
>
> [...]
>
>> +#include<linux/kernel.h>
>> +#include<linux/dma-mapping.h>
>> +#include<linux/platform_device.h>
>> +#include<linux/interrupt.h>
>> +#include<linux/pinctrl/machine.h>
>
> #include <linux/ioport.h> for DEFINE_RES_xxx at below.
>
>> +
>> +#include<plat/devs.h>
>> +#include<plat/pinctrl.h>
>> +
>> +#include<mach/map.h>
>> +
>> +static struct resource exynos4_pinctrl_resource0[] = {
>> + ? ? [0] = {
>> + ? ? ? ? ? ? .start ?= EXYNOS4_PA_GPIO1,
>> + ? ? ? ? ? ? .end ? ?= EXYNOS4_PA_GPIO1 + SZ_4K - 1,
>> + ? ? ? ? ? ? .flags ?= IORESOURCE_MEM,
>> + ? ? },
>
> [0] = DEFINE_RES_MEM(EXYNOS4_PA_GPIO1, SZ_4K),
>
>> + ? ? [1] = {
>> + ? ? ? ? ? ? .start ?= IRQ_GPIO_XA,
>> + ? ? ? ? ? ? .end ? ?= IRQ_GPIO_XA,
>> + ? ? ? ? ? ? .flags ?= IORESOURCE_IRQ,
>> + ? ? },
>
> [1] = DEFINE_RES_IRQ(IRQ_GPIO_XA),
>
> But I'm thinking, we need to move to use EXYNOS4_IRQ_GPIO_XA here for
> both EXYNOS4 and EXYNOS5 and as a note, I'm working on updating IRQ
> naming you can see it in this week :)

Thanks for reviewing this patch series. I will use DEFINE_RES_xxx for
resource instantiation.

Regards,
Thomas.

[...]
