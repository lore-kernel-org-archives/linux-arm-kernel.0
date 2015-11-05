From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 5 Nov 2015 15:06:43 +0100
Subject: [RFC PATCH 4/7] pinctrl: sunxi: remove redundant "depends on
 RESET_CONTROLLER"
In-Reply-To: <CACRpkdYmdyxi+6fZNGffE6-JBZGkyq3F__Ywc4rCYYEsQeimMQ@mail.gmail.com>
References: <1446722128-11961-1-git-send-email-yamada.masahiro@socionext.com>
 <1446722128-11961-5-git-send-email-yamada.masahiro@socionext.com>
 <CACRpkdYmdyxi+6fZNGffE6-JBZGkyq3F__Ywc4rCYYEsQeimMQ@mail.gmail.com>
Message-ID: <CACRpkdb_TBDdL_Bt=8J_Sb5APq-V-rpwXqLZSjAWgtCZ10NG8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 5, 2015 at 2:40 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
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

You could of course replace the depends with select in this
file so the menu options don't get hidden, as seems to be
the problem as described in 0/7.

Yours,
Linus Walleij
