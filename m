From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 11 Oct 2017 10:43:06 +0200
Subject: [PATCH v6 1/2] dt-bindings: gpio: uniphier: add UniPhier GPIO
 binding
In-Reply-To: <CACRpkdaJE_-tfZ+Mr3UowY9W0EdEwWEMdfhCfkj7VVOzje7MrA@mail.gmail.com>
References: <1506480022-8995-1-git-send-email-yamada.masahiro@socionext.com>
 <1506480022-8995-2-git-send-email-yamada.masahiro@socionext.com>
 <CACRpkdaJE_-tfZ+Mr3UowY9W0EdEwWEMdfhCfkj7VVOzje7MrA@mail.gmail.com>
Message-ID: <CACRpkdaNhzM=p971eW+wNhkaOLyNgszx3qwJp1C5RUgVQc9s6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 11, 2017 at 10:35 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Wed, Sep 27, 2017 at 4:40 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>
>> This GPIO controller is used on UniPhier SoC family.
>>
>> The vendor specific property "socionext,interrupt-ranges" is for
>> specifying interrupt mapping to the parent interrupt controller
>> because the mapping is not contiguous.  It works like "ranges",
>> but transforms "interrupts" instead of "reg".
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>
> Patch applied.
>
>> +- socionext,interrupt-ranges: Specifies an interrupt number mapping between
>> +  this GPIO controller and its interrupt parent, in the form of arbitrary
>> +  number of <child-interrupt-base parent-interrupt-base length> triplets.
> (...)
>> +               socionext,interrupt-ranges = <0 48 16>, <16 154 5>, <21 217 3>;
>
> Still uncertain about that thing.
>
> But as it is, you need running code, and we have rough consensus.
>
> So merging.
>
> If it turns out to be a bad binding we may need to patch in an alternative
> later.

Sorry I had to take it back out, because the <dt-bindings/*> stuff in the
other patch should also be in this patch rather than in the driver.

Please move that over here, and if you insist on those macros, also
use them in the example so we understand how this is supposed to
be used, i.e. also add a consumer node to the bindings example
if it is gonna use magic macros.

Yours,
Linus Walleij
