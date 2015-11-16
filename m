From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 16 Nov 2015 12:40:09 +0900
Subject: [RFC PATCH 4/7] pinctrl: sunxi: remove redundant "depends on
 RESET_CONTROLLER"
In-Reply-To: <CACRpkdYmdyxi+6fZNGffE6-JBZGkyq3F__Ywc4rCYYEsQeimMQ@mail.gmail.com>
References: <1446722128-11961-1-git-send-email-yamada.masahiro@socionext.com>
 <1446722128-11961-5-git-send-email-yamada.masahiro@socionext.com>
 <CACRpkdYmdyxi+6fZNGffE6-JBZGkyq3F__Ywc4rCYYEsQeimMQ@mail.gmail.com>
Message-ID: <CAK7LNAThCGYWjXD4=OdgukUBLhyAtmHFH6VXO1V4DCFCpfTRjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus

2015-11-05 22:40 GMT+09:00 Linus Walleij <linus.walleij@linaro.org>:
> On Thu, Nov 5, 2015 at 12:15 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>
>> ARCH_SUNXI selects RESET_CONTROLLER.
>> The dependency "depends on RESET_CONTROLLER" is already met.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> NACK, this pin controller needs that as dependency, I don't worry
> that it's overspecified.
>
> They both do this:
> #include <linux/reset.h>
>
> And the object should specify its dependencies, not rely on them
> being implicitly available.
>
> The dep is there for human readers too, not just machines. And to
> them, this is helpful information.

How strict we should follow this rule?

Many drivers depend on OF, but do they all have "depends on OF"?





-- 
Best Regards
Masahiro Yamada
