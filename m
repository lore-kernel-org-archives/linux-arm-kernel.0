From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 16 Jun 2013 12:55:25 +0200
Subject: [PATCH 1/3] drivers: pinctrl sleep and idle states in the core
In-Reply-To: <51BA4158.906@wwwdotorg.org>
References: <1370439873-30053-1-git-send-email-linus.walleij@stericsson.com>
 <51AF73E9.90506@wwwdotorg.org>
 <CACRpkdY_s_RkErKLqVOWdE-A80CZOq7+VZSE8jcYSUbYkvsYYQ@mail.gmail.com>
 <51BA4158.906@wwwdotorg.org>
Message-ID: <CACRpkda_tYONYU-N2M+j19A09iNP_dBWE8eBkOrL2LTrx42k_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 12:02 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 06/11/2013 02:28 AM, Linus Walleij wrote:
>> I tried to create a refactoring patch for this but couldn't come
>> up with anything apropriate along the lines above. For example
>> this function:
> ...
>
> Don't you just want something very roughly like:
>
> int pinctrl_pm_select_xxx_state(struct device *dev,
>                 unsigned long offset, char *name)
> {
>         struct dev_pin_info *pins = dev->pins;
>         struct pinctrl_state **s = (void *)(((char *)pins) + offset)
(...)
>     return pinctrl_pm_select_xxx_state(dev,
>                 offsetof(struct dev_pin_info, default_state),
>                 "default");
> }

Argh that seems a bit too esoteric to save these few
lines, maybe it's me being too stupid to parse this
but it makes the code less maintainable for the pinctrl
maintainer atleast so will not happen right now.

But it is clever still. :-)

Yours,
Linus Walleij
