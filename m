From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sat, 24 Aug 2013 22:35:32 +0800
Subject: [GIT PULL for v3.12] pull request from pxa git tree on mmp-irq
In-Reply-To: <CAMLZHHTpQ1ZnAiqn_TLgs0W6WHaagkrnS-JXP4YaY4bE-yMUsg@mail.gmail.com>
References: <CAN1soZwOH0hifZPgJp7btfbT8zn9OXHvy-+2zYqH3Mob4NAuFQ@mail.gmail.com>
 <CAMLZHHTpQ1ZnAiqn_TLgs0W6WHaagkrnS-JXP4YaY4bE-yMUsg@mail.gmail.com>
Message-ID: <CAN1soZwkL-PegbG=F+Aay64yccLnfsWau=-w3-orkYB6CMs-qA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 24, 2013 at 10:12 PM, Daniel Drake <dsd@laptop.org> wrote:
> On Sat, Aug 24, 2013 at 7:44 AM, Haojian Zhuang
> <haojian.zhuang@gmail.com> wrote:
>> Hi Arnd, Olof & Kevin,
>>
>> Please pull mmp-irq branch from pxa git tree. It moved irq driver from
>> arch-mmp directory to irqchip directory, since it's used to support
>> multiplatform.
>
> Thanks for continuing the work on this.
>
> It looks like the final patch is missing a response from the review from Arnd.
> http://article.gmane.org/gmane.linux.ports.arm.kernel/255492
>
> Looks good otherwise.
>
> Daniel


>I'd suggest passing IRQ_MMP2_PMIC_BASE and the other constants from the caller
>and changing the prototype accordingly so you can do

>mmp2_init_icu(0, IRQ_MMP2_PMIC_BASE, IRQ_MMP2_RTC_BASE, IRQ_MMP2_KEYPAD_BASE,
>IRQ_MMP2_TWSI_BASE, IRQ_MMP2_MISC_BASE, IRQ_MMP2_MIPI_HSI1_BASE,
>IRQ_MMP2_MIPI_HSI0_BASE);

I'm sorry that I forget to response the mail. I don't want to use any
irq macro define in
irq-mmp driver at this time.

1. Those IRQ macro are defined in <mach/irqs.h>. And they're widely
used in mach-mmp
directory. In order to support multiplatform, I avoid to include this
head file in irq-mmp driver.
I don't want to use any macro in this head file. Otherwise, it'll
break my effort.

2. I also don't want to define a function with too much parameters.
It's not easy to read.

Best Regards
Haojian
