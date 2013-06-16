From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 16 Jun 2013 14:35:58 +0200
Subject: [PATCH 5/5] pinctrl: rockchip: correctly handle arguments of
 pinconf options
In-Reply-To: <201306161302.32156.heiko@sntech.de>
References: <201306141741.46077.heiko@sntech.de>
 <201306141744.21117.heiko@sntech.de>
 <CACRpkdY6pmS=5rphvYdt_8yKYJq8ADu0omy48ncZ3LFtEUf7yg@mail.gmail.com>
 <201306161302.32156.heiko@sntech.de>
Message-ID: <CACRpkdZxO-8rQPBRPsxAx8OBfwvh_BQuts7NAi379gMZG+1ocg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 16, 2013 at 1:02 PM, Heiko St?bner <heiko@sntech.de> wrote:

>> > -               *config = 0;
>> > +               pull = rockchip_get_pull(bank, pin - bank->pin_base);
>> > +               *config = (pull == param) ? 1 : 0;
>>
>> And then I guess you should emit PIN_CONFIG_BIAS_DISABLE
>> here as well.
>
> rockchip_get_pull does emit PIN_CONFIG_BIAS_DISABLE when the pull is disabled,
> only wrongly does add the argument here.

Ah, right.

> But I'm actually not quite sure what the expected behaviour is here at all :-)
>
> Say the pin is in the "pin-default" pull state and the query in config_get is
> for "bias-disable", what would be the expected bahviour/return value in this
> case?

return -EINVAL; ?

Hm it was some time since I designed this...

Yours,
Linus Walleij
