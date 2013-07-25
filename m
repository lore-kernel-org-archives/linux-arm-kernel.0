From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Jul 2013 11:37:52 +0200
Subject: Issue with gpio and pinmux
In-Reply-To: <51EB590A.4010600@wwwdotorg.org>
References: <51E667BC.3070804@parrot.com> <51E82FBB.1080905@wwwdotorg.org>
 <CACRpkdb1n07KoQZSme1EMJfV-9pHr-kd_1eJ6HsBV5gz7Dh3Ww@mail.gmail.com>
 <51EB590A.4010600@wwwdotorg.org>
Message-ID: <CACRpkdZdbxEt67+YBKif4-BKAToOmN0_c8HFOdjSG91dtJwJQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 21, 2013 at 5:44 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> Actually, a better way to do (c) might be to just add an extra "op" to
> struct pinmux_ops; something like validate_gpio_mux(), passing in
> information such as whether a mux function is in effect on that pin,
> whether the pin is already claimed as a GPIO, and whether the function
> is being called to check a GPIO-claim or mux-claim operation . If the op
> is missing, no "dual claim" is allowed. If the op is present, the code
> in the op validates whether the particular GPIO is allowed to be claimed
> while the particular mux function is active.
>
> That way, I think any driver that doesn't want to allow dual-claim
> doesn't have to do anything, but the few drivers that do can code up
> whatever algorithm they want; for Tegra, I'd just allow everything for
> simplicity, but we could always enhance that later if we want.

You are right, this would be an elegant solution.

Christian, are you interested in coding this up?

Yours,
Linus Walleij
