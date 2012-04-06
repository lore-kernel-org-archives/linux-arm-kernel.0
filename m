From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 6 Apr 2012 13:55:34 +0800
Subject: [PATCH v7 09/11] ARM: pxa: change gpio to platform device
In-Reply-To: <874nsx4g8d.fsf@laptop.org>
References: <1320806851-13928-1-git-send-email-haojian.zhuang@marvell.com>
 <1320806851-13928-10-git-send-email-haojian.zhuang@marvell.com>
 <87pqbl5wvt.fsf@laptop.org> <874nsx4g8d.fsf@laptop.org>
Message-ID: <CAN1soZxOX9LE2+93kKvnmLx2JpmCDWX0pDA8Cf9r4=oncdB+Yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 6, 2012 at 12:49 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi Haojian,
>
> On Fri, Apr 06 2012, Chris Ball wrote:
>> On Tue, Nov 08 2011, Haojian Zhuang wrote:
>>> Remove most gpio macros and change gpio driver to platform driver.
>>>
>>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>>
>> Please could you help me understand how this patch (which was merged
>> in 3.2) relates to mach-mmp's use of gpio-pxa? ?The patch changes
>> pxa_gpio_probe() to check for gpio0/gpio1/gpio_mux in platform data:
>> [..]
>> But the patch only adds these resources to arch/arm/mach-pxa/devices.c:
>> [..]
>> and not anywhere under arch/arm/mach-mmp, which means that when we look
>> for these names on a mach-mmp device (in my case, OLPC XO-1.75/MMP2),
>> we hit the "return -EINVAL" above due to the missing platform resources.
>> Using gpio-pxa on mach-mmp devices worked fine on kernels before 3.2.
>
> Ah, I eventually found your "ARM: mmp: append irq name of gpio device"
> patch, which was merged in 3.4-rc1 and fixes gpio-pxa on mach-mmp.
> I think this patch should go to stable@, since the regression is
> still unfixed in 3.2 and 3.3.
>
Who or which mailing list should I cc for this fix on 3.2 and 3.3?

Best Regards
Haojian
