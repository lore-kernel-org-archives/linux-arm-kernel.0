From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Jan 2013 09:55:32 +0100
Subject: [PATCH 0/4] gpio: introduce descriptor-based interface
In-Reply-To: <50FB8986.9010205@nvidia.com>
References: <1357629535-26033-1-git-send-email-acourbot@nvidia.com>
 <CACRpkda6dqAj+DzrMCnKET7Z9PtuW0+k9ea3YDL8Z1D=oFVRpQ@mail.gmail.com>
 <50F7E83E.8000105@uclinux.org>
 <201301170850.43655.sfking@fdwdc.com> <50FB8986.9010205@nvidia.com>
Message-ID: <CACRpkdZHgEQRwKZXS6Juk763z+AAXB3SnG=wLdX+aJY0X=nYKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 20, 2013 at 7:07 AM, Alex Courbot <acourbot@nvidia.com> wrote:

> Actually the question of switching to GPIOlib is only worth being asked if
> you are making use of drivers that require GENERIC_GPIO. If this is not the
> case and your GPIOs are only used by your own platform code, you can always
> give up using defining GENERIC_GPIO and continue implementing them your own
> way.

Agreed. The problem can be summed up like this:

#include <linux/gpio.h>

Considered ambiguous.

#include <asm/foo/bar/baz-gpio.h>

OK with me.

Yours,
Linus Walleij
