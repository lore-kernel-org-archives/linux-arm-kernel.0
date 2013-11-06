From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 6 Nov 2013 10:29:47 +0100
Subject: [PATCH 3/4] ARM: pinctrl: Add Broadcom Capri pinctrl driver
In-Reply-To: <527835FE.2030102@wwwdotorg.org>
References: <1380846199-12829-1-git-send-email-syin@broadcom.com>
 <051069C10411E24D9749790C498526FA1BE0B7D7@SJEXCHMB12.corp.ad.broadcom.com>
 <CACRpkdYSLxp2M4HghcUdjEYGh-UQ+DaiCGp6yee+Qds6DR9poA@mail.gmail.com>
 <201311050026.56321.heiko@sntech.de>
 <527835FE.2030102@wwwdotorg.org>
Message-ID: <CACRpkdaNnsM1cVTooYH=ePgjtvjrCiwuOD4oyYBZ_uzTYBnA_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 5, 2013 at 1:04 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 11/04/2013 04:26 PM, Heiko St?bner wrote:

> Pure Boolean values should be represented as a valueless property. If
> the property is present, the value is true, otherwise false.
>
> However, pinctrl bindings often don't represent Boolean values, but
> rather tri-states, with the following values:
>
> * Don't touch this configuration option at all (missing)
> * Enable the option (<1>)
> * Disable the option (<0>)

But in this case we actually have these booleans to specify
exactly what we want to do:

bias-disable            - disable any pin bias
bias-high-impedance     - high impedance mode ("third-state", "floating")
bias-bus-hold           - latch weakly
bias-pull-up            - pull up the pin
bias-pull-down          - pull down the pin
bias-pull-pin-default   - use pin-default pull state

Yours,
Linus Walleij
