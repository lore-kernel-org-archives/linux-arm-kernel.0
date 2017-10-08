From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 8 Oct 2017 22:42:22 +0900
Subject: [PATCH v7 1/2] dt-bindings: gpio: uniphier: add UniPhier GPIO
 binding
In-Reply-To: <CACRpkdYJSXH+94QScrpSPdfy8ULa6dV2q0qRjsfKAAWSRuKTKQ@mail.gmail.com>
References: <1506480343-9597-1-git-send-email-yamada.masahiro@socionext.com>
 <1506480343-9597-2-git-send-email-yamada.masahiro@socionext.com>
 <CACRpkdYJSXH+94QScrpSPdfy8ULa6dV2q0qRjsfKAAWSRuKTKQ@mail.gmail.com>
Message-ID: <CAK7LNASz+_v=AFJqVchVRZJbXH0Rne0dO9MUCSao0UrFYexGmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,


2017-09-27 22:42 GMT+09:00 Linus Walleij <linus.walleij@linaro.org>:
> On Wed, Sep 27, 2017 at 4:45 AM, Masahiro Yamada
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
> I don't think Rob has seen the new interrupt range thing?
> (It's not a big deal. Things like these are a bit fuzzy.)
>
>> +               socionext,interrupt-ranges = <0 48 16>, <16 154 5>, <21 217 3>;
>
> If it is as you say, that other SoCs are doing the same, we should
> think about creating a generic property for this. Like
> hierarchy-interrupt-ranges or so.
>
> I kind of liked the old patch where it was just "interrupts" and
> then you looked it up from the irq subsystem. (tglx even ACKed
> the patch).
>
> But I want the DT people to say something here.
>
> Yours,
> Linus Walleij


I explained the technical background of this approach,
but I have not had any comment.
(DT people are silent, too)

Is this driver applicable?



-- 
Best Regards
Masahiro Yamada
