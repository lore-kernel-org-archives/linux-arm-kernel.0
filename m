From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Feb 2014 10:41:08 +0100
Subject: [PATCH v2 1/9] ARM: centralize common multi-platform kconfig
 options
In-Reply-To: <CAL_JsqK1AvyCSb3yDxGO41W3iHN5yRaPOkRUbds8g7A3W4FNzA@mail.gmail.com>
References: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
 <1392153119-23248-2-git-send-email-robherring2@gmail.com>
 <CACRpkdb5DzXbFV=mH24HuyGQ91OjPYx5=bMeNSb+xQ8q4epGiA@mail.gmail.com>
 <CAL_JsqK1AvyCSb3yDxGO41W3iHN5yRaPOkRUbds8g7A3W4FNzA@mail.gmail.com>
Message-ID: <CACRpkdaMXkzqnnK+nkMnR2WjF2UPhU7Nis8Sc=bL4meSav0T3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 14, 2014 at 3:02 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Fri, Feb 14, 2014 at 4:40 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Tue, Feb 11, 2014 at 10:11 PM, Rob Herring <robherring2@gmail.com> wrote:
>>
>>> From: Rob Herring <robh@kernel.org>
>>>
>>> Multi-platform requires various kconfig options to be selected, so
>>> platforms don't need to select them individually.
>>>
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>> Cc: Russell King <linux@arm.linux.org.uk>
>>
>> OK makes sense. Maybe a bit unintuitive that multiplat
>> make gpiolib wanted optional and then platforms override
>> this by requiring it, but whatever, I cannot think of anything
>> better.
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> It's really just about making gpiolib visible. Can we just kill the
> symbol or there are still non-gpiolib users that would conflict?

Oh no and yes. I'm working on trying to get rid of that
old cruft, but the problem is that I basically have to acquire
or delete these platforms to get them off the "generic GPIO"
API (i.e. just a set of functions with certain names).

Old habits die hard you know.

Having the symbol default-selected by multiplatform definately
puts up a roadblock stopping new platforms from doing
anything like that again so at second thought I really like
this patch:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
