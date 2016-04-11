From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 11 Apr 2016 21:51:26 +0200
Subject: [PATCH] ARM: pxa: activate pinctrl for device-tree machines
In-Reply-To: <CACRpkdYnv6nVQEdErcmKuwUJ-yinrUUGaG_jkKVDsscXGdMugQ@mail.gmail.com>
 (Linus Walleij's message of "Sun, 3 Apr 2016 21:13:44 +0200")
References: <1459623362-18324-1-git-send-email-robert.jarzmik@free.fr>
 <CACRpkdYnv6nVQEdErcmKuwUJ-yinrUUGaG_jkKVDsscXGdMugQ@mail.gmail.com>
Message-ID: <87oa9fudoh.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> On Sat, Apr 2, 2016 at 8:56 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>
>> Pincontrol is not yet ready for all PXA platforms.
>> For example, a legacy platform, if PINCTRL was activated, will fail its
>> calls to gpio_request() or gpio_direction_output(), as the pinctrl
>> driver might not be available, such as for pxa25x and pxa3xx.
>>
>> As a step forward, activate pincontrol for all device-tree available
>> machines, ie. pxa27x device-tree based and pxa3xx device-tree based.
>>
>> If it appears later that pincontrol is also required for legacy
>> platforms and if the mfp->pinctrl conversion can be achieved, then
>> PINCTRL will be activated for the whole PXA architecture.
>>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
Thanks, queued to pxa/for-next.

Cheers.

-- 
Robert
