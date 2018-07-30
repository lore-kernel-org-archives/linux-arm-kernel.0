From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Mon, 30 Jul 2018 11:39:07 +0300
Subject: [PATCH v2 2/2] spi: add SPI controller driver for UniPhier SoC
In-Reply-To: <002901d427c6$6b9a4ff0$42ceefd0$@socionext.com>
References: <1532588943-19481-1-git-send-email-hayashibara.keiji@socionext.com>
 <1532588943-19481-3-git-send-email-hayashibara.keiji@socionext.com>
 <CAHp75VcEdxDEo0T5_9BzOPaeaqjbmbrWmaE9+ZuUDYhjh6jpVw@mail.gmail.com>
 <1532624495.2283.197.camel@impinj.com>
 <002901d427c6$6b9a4ff0$42ceefd0$@socionext.com>
Message-ID: <CAHp75VdrpOkonozNRUCzchsNHbgV=djecVDr0-fRiYAa4iDE0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2018 at 8:30 AM, Keiji Hayashibara
<hayashibara.keiji@socionext.com> wrote:
> Hello Trent and Andy,

>> > > +       ckrat = roundup(ckrat, 2);
>> >
>> > ckrat += ckrat & 1;
>>
>> Either way, the compiler produces the same code:
>>
>>  add r0, r0, #1
>>  bic r0, r0, #1
>>
>> I.e., ckrat = (ckrat + 1) & ~1, one "add" and one "and".
>>
>> Might as well use the macro so it's clear. There is also round_up(x,y), which I believe is intended to be used
>> only with power of 2 values of y.
>
> I confirmed round_up() macro.
> This macro is optimized to power of 2 argument,
> and it matches to this case and clear.
>
> I will replace to round_up() macro.

Good!


-- 
With Best Regards,
Andy Shevchenko
