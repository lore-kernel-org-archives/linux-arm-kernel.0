From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 23 Apr 2013 15:49:43 +0800
Subject: gpio-pxa initcall level change and machine init breakage
In-Reply-To: <CACRpkdbk24kR75fanvXVAocnuozNq_=jWDSPHPCWhbZCOrN5_Q@mail.gmail.com>
References: <5172B398.7060706@newsguy.com>
 <CAD6h2NSRA9w7GZLQGgK-+TvEAsxwOHow5_26JyVUA6YQyj3OQg@mail.gmail.com>
 <517466F6.3000003@newsguy.com>
 <CAD6h2NSy0=3P-PHdCiJJQG_jvGaFnr7uex+Uxs=0F-VsUxtPWg@mail.gmail.com>
 <CACRpkdbk24kR75fanvXVAocnuozNq_=jWDSPHPCWhbZCOrN5_Q@mail.gmail.com>
Message-ID: <CAD6h2NSpDc-uaB5e5BLmr1u89PZ1Z-wQO=a77JtBcmL0R+iTdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 April 2013 15:26, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Apr 22, 2013 at 2:58 AM, Haojian Zhuang
> <haojian.zhuang@linaro.org> wrote:
>> On 22 April 2013 06:23, Mike Dunn <mikedunn@newsguy.com> wrote:
>>> Will the big guy see this?  Only posted to linux-arm-kernel ML.
>>>
>>> Thanks Haojian,
>>> Mike
>
> I guess Haojian is referring to me, not Torvalds ...
>
>> Sorry, I forgot to loop him in.
>>
>> Linus,
>> Should I send the revert commit to you? Or will you revert it directly?
>
> How hard is it to fix the real problem?
>
> I'm looking at arch/arm/mach-pxa/palmtreo.c, would
> something like this solve the problem:
>
Your fix could resolve the issue on palmtreo. After grep
gpio_request() in arch-pxa,
I found that there're a lot of files using gpio_request() in .init_machine().

Regards
Haojian
