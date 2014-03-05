From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 5 Mar 2014 14:37:16 +0800
Subject: [PATCH v2 1/7] ARM: mm: Introduce archdata.dma_pfn_offset
In-Reply-To: <CACRpkdaRgf2yn51HYnJHBVKdrGdYhwSr0yf2GLmT3DwzmPbMDA@mail.gmail.com>
References: <1393535872-20915-1-git-send-email-santosh.shilimkar@ti.com>	<1393535872-20915-2-git-send-email-santosh.shilimkar@ti.com>
 <CACRpkdaRgf2yn51HYnJHBVKdrGdYhwSr0yf2GLmT3DwzmPbMDA@mail.gmail.com>
Message-ID: <5316C61C.9070206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 05 March 2014 12:45 PM, Linus Walleij wrote:
> On Fri, Feb 28, 2014 at 5:17 AM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
> 
>> From: Grygorii Strashko <grygorii.strashko@ti.com>
>>
>> In most of cases DMA addresses can be performed using offset value of
>>  Bus address space relatively to physical address space as following:
>>
>> PFN->DMA:
>>  __pfn_to_phys(pfn + [-]dma_pfn_offset)
>>
>> DMA->PFN:
>>  __phys_to_pfn(dma_addr) + [-]dma_pfn_offset
>>
>> This patch introduces new field dma_pfn_offset in ARM dev_archdata
>> structure which has to be filed per-device at arch init time
>> (simplest way is to use Platform bus notifier to handle
>> BUS_NOTIFY_ADD_DEVICE event) and updates DMA address translation
>> routines in order to accommodate bus offset value by default.
>>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Olof Johansson <olof@lixom.net>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> This looks like exactly what I need to proceed to multiplatform on
> Integrator.
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
Thanks Linus.

Just to make folks aware on the thread, after some more inputs and discussion
at connect, looks like we need to make this work for other arch's too. So am
going to move dma_pfn_offset from archdata to device_dma_parameters  so that
arch code as well as driver code should be able to access/modify the pfn
offset.

Regards,
Santosh
