From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 10 Dec 2013 15:54:06 +0300
Subject: [PATCH v2 02/11] arm: pxa27x: support ICP DAS LP-8x4x
In-Reply-To: <CACRpkdYVsGSyMS6sSTqqJ4XrE3GqpWkJsY7GDazi5ix7xjKQ=Q@mail.gmail.com>
References: <1385879185-22455-3-git-send-email-ynvich@gmail.com>
 <1386348542-9584-1-git-send-email-ynvich@gmail.com>
 <CACRpkdYVsGSyMS6sSTqqJ4XrE3GqpWkJsY7GDazi5ix7xjKQ=Q@mail.gmail.com>
Message-ID: <CA+E=qVc4pNU_e5YjUZX7hG21FzS3omdd1XvgwFcHQy2z_Mnm8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 3:43 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Dec 6, 2013 at 5:48 PM, Sergei Ianovich <ynvich@gmail.com> wrote:
>
>> ICP DAS calls LP-8x4x 'programmable automation controller'. It is
>> an industrial computer based on PXA270 SoC. They ship it with a 2.6.19
>> kernel and proprietary kernel module and userspace library to access
>> its industrial IO.
>
> OK... so we only have device tree support for PXA3xx and noone is
> working on PXA2xx. And now we pile up some more legacy code.
> Such is life. But this:
>
>> +static unsigned long lp8x4x_pin_config[] = {
>> +       /* MMC */
>> +       GPIO32_MMC_CLK,
>> +       GPIO112_MMC_CMD,
>> +       GPIO92_MMC_DAT_0,
>> +       GPIO109_MMC_DAT_1,
>> +       GPIO110_MMC_DAT_2,
>> +       GPIO111_MMC_DAT_3,
>> +
>> +       /* USB Host Port 1 */
>> +       GPIO88_USBH1_PWR,
>> +       GPIO89_USBH1_PEN,
>> +};
>
> (...)
>> +static void __init lp8x4x_init(void)
>> +{
>> +       pxa2xx_mfp_config(ARRAY_AND_SIZE(lp8x4x_pin_config));
> (...)
>
> Argh! Now you're adding another user for a legacy custom pin control
> implementation. But if noone is going to modernize PXA2xx what
> can we do :-/

I tried a ~year ago, but it's not so trivial. PXA2xx has no separate
pin control module, it's
highly integrated into GPIO controller. I've asked the maillist what
should I do for that case, but AFAIR no one answered.

Regards
Vasily

> Yours,
> Linus Walleij
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
