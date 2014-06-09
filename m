From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Jun 2014 13:36:33 +0200
Subject: [PATCH 2/4] ARM: mach-s5p: get rid of all <mach/gpio.h> headers
In-Reply-To: <4544212.mqY6dSouMv@wuerfel>
References: <1401888838-3126-1-git-send-email-linus.walleij@linaro.org>
 <1401888838-3126-3-git-send-email-linus.walleij@linaro.org>
 <4544212.mqY6dSouMv@wuerfel>
Message-ID: <CACRpkdZMwLv1rHS+mSAT4YP3F0VUtt9E-u3p89a-YzRRFbugGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 4, 2014 at 3:58 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 04 June 2014 15:33:56 Linus Walleij wrote:
>> This renames all the local <mach/gpio.h> headers in the S5P platforms
>> to <mach/gpio-samsung.h> indicating a scope local to this platform,
>> and cuts the implicit inclusion of <mach/gpio.h> from <linux/gpio.h>
>> by removing the use of NEED_MACH_GPIO_H from all S5P variants.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Hmm, this patch will obviously clash with the removal of S5p64xx
> and s5pc100.

So it is happening? I was actually expecting that to happen in
v3.14 or so and now I finally lost my patience ;-)

> It shouldn't be hard to resolve the conflict when we
> merge both into arm-soc/next/cleanup,

First come, first serve. I will send my pull request at the end
of the merge window I hope. If removal comes first, I'll rebase.

Linus
