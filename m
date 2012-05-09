From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 09 May 2012 11:28:49 +0100
Subject: [PATCH 11/15] drivers/mfd: Enable Device Tree for ab8500-core
 driver
In-Reply-To: <CACRpkdaju5y6pduWrkH97LujzqJu5hAaGozyHY3Rsvvn7ZyKhA@mail.gmail.com>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-12-git-send-email-lee.jones@linaro.org>
 <CACRpkdaju5y6pduWrkH97LujzqJu5hAaGozyHY3Rsvvn7ZyKhA@mail.gmail.com>
Message-ID: <4FAA46E1.4050708@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/12 10:02, Linus Walleij wrote:
> On Fri, May 4, 2012 at 8:23 PM, Lee Jones<lee.jones@linaro.org>  wrote:
>
>> This patch will allow the ab8500-core driver to be probed and set up
>> when booting when Device Tree is enabled. This includes platform ID
>> look-up which identifies the machine it is currently running on. If
>> we are undergoing a DT enabled boot, we will refuse to setup each of
>> the other ab8500-* devices, as they will be probed individually by DT.
>>
>> Signed-off-by: Lee Jones<lee.jones@linaro.org>
> (...)
>> +       else if (np)
>> +               ret = of_property_read_u32(np, "stericsson,irq-base",&ab8500->irq_base);
>> +
>> +       if (ab8500->irq_base == 0) {
>
> Shouldn't this be (av8500->irq_base == NO_IRQ) now that we're tranisitioning to
> use 0 as NO_IRQ?

Sure, why not.

> Apart from that it looks good to me:
> Acked-by: Linus Walleij<linus.walleij@linaro.org>


-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
