From: mikedunn@newsguy.com (Mike Dunn)
Date: Tue, 23 Apr 2013 12:42:48 -0700
Subject: gpio-pxa initcall level change and machine init breakage
In-Reply-To: <CACRpkdbk24kR75fanvXVAocnuozNq_=jWDSPHPCWhbZCOrN5_Q@mail.gmail.com>
References: <5172B398.7060706@newsguy.com>
 <CAD6h2NSRA9w7GZLQGgK-+TvEAsxwOHow5_26JyVUA6YQyj3OQg@mail.gmail.com>
 <517466F6.3000003@newsguy.com>
 <CAD6h2NSy0=3P-PHdCiJJQG_jvGaFnr7uex+Uxs=0F-VsUxtPWg@mail.gmail.com>
 <CACRpkdbk24kR75fanvXVAocnuozNq_=jWDSPHPCWhbZCOrN5_Q@mail.gmail.com>
Message-ID: <5176E438.80800@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/23/2013 12:26 AM, Linus Walleij wrote:
> On Mon, Apr 22, 2013 at 2:58 AM, Haojian Zhuang
> <haojian.zhuang@linaro.org> wrote:
>> On 22 April 2013 06:23, Mike Dunn <mikedunn@newsguy.com> wrote:
>>> Will the big guy see this?  Only posted to linux-arm-kernel ML.
>>>
>>> Thanks Haojian,
>>> Mike
> 
> I guess Haojian is referring to me, not Torvalds ...


Oops, sorry Linus.  Note that the other Linus has the patch in his official tree.

[...]


> 
> How hard is it to fix the real problem?
> 
> I'm looking at arch/arm/mach-pxa/palmtreo.c, would
> something like this solve the problem:
> 
>>From 5acf99a576f563d48ca5d25b9e5a1bcdd09331eb Mon Sep 17 00:00:00 2001
> From: Linus Walleij <linus.walleij@linaro.org>
> Date: Tue, 23 Apr 2013 09:24:43 +0200
> Subject: [PATCH] ARM: pxa: set up Treo GPIOs using device initcall
> 
> This augments the Treo setup to grab LCD GPIOs at device_initcall()
> level instead of at init_machine() time, and propagates any
> returned errors so that deferred probe will work.


Thanks for the patch.  I am not having initial success, but will troubleshoot
tomorrow morning.

On a more general note... I'm surprised that gpiolib can not run earlier, for
something so low-level.  The kernel documentation on gpio talks about running
early.  I'm not involved in nor knowledgeable of the pinctrl/gpio work so I
won't question the need.  I'll probably be able to educate myself some more
tomorrow.

Thanks again,
Mike
