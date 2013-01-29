From: olof@lixom.net (Olof Johansson)
Date: Tue, 29 Jan 2013 10:51:58 -0800
Subject: [PATCH 5/5] ARM: ux500: select the DB8540 pin controller
In-Reply-To: <CACRpkdZuu0skVSPV5qcUx3g5UYGxzigeCDkN_NeuNB+Ak8m3wQ@mail.gmail.com>
References: <1359381151-28127-1-git-send-email-linus.walleij@stericsson.com>
 <20130128230059.GE7789@quad.lixom.net>
 <CACRpkdZuu0skVSPV5qcUx3g5UYGxzigeCDkN_NeuNB+Ak8m3wQ@mail.gmail.com>
Message-ID: <CAOesGMjvVQXwi5VoW+NYsmRXm8EJutzunjA8QXOzcVVK09ER4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 10:16 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Tue, Jan 29, 2013 at 12:00 AM, Olof Johansson <olof@lixom.net> wrote:
>> On Mon, Jan 28, 2013 at 02:52:31PM +0100, Linus Walleij wrote:
>>> From: Linus Walleij <linus.walleij@linaro.org>
>>>
>>> The pin controller is an inherent part of the SoC, without
>>> it the system will not boot, thus it needs to be selected
>>> from Kconfig.
>>>
>>> Cc: arm at kernel.org
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>> ---
>>> Requesting ACK from ARM SoC on this patch.
>>
>> Acked-by: Olof Johansson <olof@lixom.net>
>
> Thanks!
>
>> ... but I wonder if this is growing out of hand. Since they will always
>> be selected (and required) for UX500_SOC_DB8500, why not just make them
>> silent options that default to y with that as a depend?
>
> So either I do it like this by using select FOO in the
> Kconfig for the affected SoC, or I just turn it around
> and make it depend on the affected SoC and select it
> to "y" default.
>
> It's like eating eggs from the little or big end or something.
>
> This current approach has the upside of not proliferating
> the SoC Kconfig symbol outside of the ARM tree, but
> I have no strong preference...
>
> All this stuff used to live in the arch/arm/mach-foo
> folders in the past, like the clocks you just have to
> default-enable it somehow.

Hm. Damned if we do, damned if we don't.

Well, the slightly awkward part is probably that we split them up in a
bunch of Kconfig options that we need to select, but at the end of the
day, they are all either selected or unselected together. So the
granularity just means more Kconfig select lines.

Still, not a horrible problem, it just started to look at bit
excessive in the arch/arm/mach-* Kconfig.


-Olof
