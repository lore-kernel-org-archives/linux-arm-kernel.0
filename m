From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 8 Aug 2012 10:43:06 +0200
Subject: [PATCH] pinctrl/nomadik: add ASIC DB8450 pinctrl driver
In-Reply-To: <502179EA.30301@wwwdotorg.org>
References: <1344341538-32223-1-git-send-email-linus.walleij@stericsson.com>
 <502179EA.30301@wwwdotorg.org>
Message-ID: <CACRpkdZ+SsMzAGotOVZ5HrOEQUDs-8ixBYwuLu1ff6Qe=84OdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 7, 2012 at 10:26 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

>> @@ -1722,6 +1722,8 @@ static int __devinit nmk_pinctrl_probe(struct platform_device *pdev)
>>       /* Poke in other ASIC variants here */
>>       if (version == PINCTRL_NMK_DB8500)
>>               nmk_pinctrl_db8500_init(&npct->soc);
>> +     if (platid->driver_data == PINCTRL_NMK_DB8540)
>> +             nmk_pinctrl_db8540_init(&npct->soc);
>
> I'm surprised one of those checks "version" and the other
> "platid->driver_data".
>
> Aside from that, this looks fine.

Bah, I'll fix this, then add your ACK.

Yours,
Linus Walleij
