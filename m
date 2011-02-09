From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 9 Feb 2011 09:23:25 +0100
Subject: [PATCH 6/9] plat-nomadik: type secondary IRQ correctly
In-Reply-To: <4D514A32.7070202@ru.mvista.com>
References: <1297156854-32295-1-git-send-email-linus.walleij@stericsson.com>
	<1297156854-32295-7-git-send-email-linus.walleij@stericsson.com>
	<4D514A32.7070202@ru.mvista.com>
Message-ID: <AANLkTim517RQ8NkHVyPsUmpCox93-qGQ=GY_-zpOVQmZ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/2/8 Sergei Shtylyov <sshtylyov@mvista.com>:
> Hello.
>
> On 08-02-2011 12:20, Linus Walleij wrote:
>
>> From: Virupax Sadashivpetimath <virupax.sadashivpetimath@stericsson.com>
>
>> Coverity found that we were checking an unsigned variable for
>> greater than zero. Type it correctly.
>
> ? There's nothing criminal in checking unsigned for > 0. Perhaps you meant
>>= 0?

Yeah the if()-clause Coverity reacted to was this:
if (nmk_chip->secondary_parent_irq >= 0) {

I'll update the patch description.

>> Signed-off-by: Virupax Sadashivpetimath
>> <virupax.sadashivpetimath@stericsson.com>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
>
> ? Twice?

Yes, for two different organizations. One pays my wages and the
other one control my work.

Let's say that I think if Greg and the Linux Foundation wasn't
doing these statistics over the organizations contributing to Linux
every kernel release, it wouldn't be such a big deal. Now
everybody wants to be in those stats. Lee from Linaro may want
to expand on this...

Yours,
Linus Walleij
