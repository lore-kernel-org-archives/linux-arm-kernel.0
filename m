From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Thu, 26 Jul 2018 16:44:08 +0300
Subject: [PATCH v2 2/2] spi: add SPI controller driver for UniPhier SoC
In-Reply-To: <001b01d424c4$66e04230$34a0c690$@socionext.com>
References: <1532588943-19481-1-git-send-email-hayashibara.keiji@socionext.com>
 <1532588943-19481-3-git-send-email-hayashibara.keiji@socionext.com>
 <CAHp75VcEdxDEo0T5_9BzOPaeaqjbmbrWmaE9+ZuUDYhjh6jpVw@mail.gmail.com>
 <001b01d424c4$66e04230$34a0c690$@socionext.com>
Message-ID: <CAHp75VfPozwBPpuP9HadSc2GVm7tbPpMxg+AtACZa9jzVGGT-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 12:38 PM, Keiji Hayashibara
<hayashibara.keiji@socionext.com> wrote:

>> > +       /* check if requested speed is too small */
>> > +       if (ckrat > SSI_MAX_CLK_DIVIDER)
>>
>> > +               return -EINVAL;
>>
>> So, does this critical?
>
> If set the value to SSI_MAX_CLK_DIVIDER, the clock frequency will be set high.
> I don't change it to high frequency, and it is daringly an error.
> On the other hand, when changing to low frequency, I will change it automatically.

No. My point is, if somehow user asks for that condition to be
happened you bail out, while when using clamp_val() you may continue
to work at maximum limit, though issue warning to user, for example.

>> > +
>> > +       if (ckrat < SSI_MIN_CLK_DIVIDER)
>> > +               ckrat = SSI_MIN_CLK_DIVIDER;
>>
>> clamp_val()  / max() ?
>
> I will modify it to use max().

See above.

-- 
With Best Regards,
Andy Shevchenko
