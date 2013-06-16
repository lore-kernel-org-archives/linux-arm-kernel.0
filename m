From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 16 Jun 2013 12:39:44 +0200
Subject: [PATCH 1/2] pinctrl: add function to parse generic pinconfig
 properties from a dt node
In-Reply-To: <2970435.N7A5210Ocy@avalon>
References: <201306102139.32444.heiko@sntech.de> <1862891.4yIecp615h@avalon>
 <201306141118.22663.heiko@sntech.de> <2970435.N7A5210Ocy@avalon>
Message-ID: <CACRpkdaEVFwdLRa7YF8P7MwuTZsrqk6A_07Ce3P6fHpv0SNn=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 4:52 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Friday 14 June 2013 11:18:22 Heiko St?bner wrote:

>> > What's the expected way to disable pull-ups in DT ? Should it be
>> > 'bias-pull-up = <0>;' or 'bias-disable;' ?
>>
>> According to the kernedoc I think both are valid and should be handled.
>> Using bias-disable is more descriptive but would also include disabling a
>> "high-impedance" or "bus-hold" bias (if supported by the hardware).
>
> OK. I still fail to see how the various bias options are supposed to interract
> together, but I don't think I'll get an answer on that.
>
>> Personally, for my rockchip stuff I go with using the
>> "bias-pull-pin-default" <-> "bias-disable".

I think bias-pull-up = <0>; should actually mean "connect the
pin to VDD" and bias-pull-down = <0>; should mean "ground
the pin".

This makes a lot of sense from the electronics side of things,
let's not create a terminology that appeals to programmers,
such that "zero always means boolean disable", because we're
dealing with electronics here.

Yours,
Linus Walleij
