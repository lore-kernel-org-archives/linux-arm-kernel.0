From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Apr 2016 11:17:08 +0200
Subject: [PATCH] pinctrl: at91-pio4: fix pull-up/down logic
In-Reply-To: <1461074628-20224-1-git-send-email-ludovic.desroches@atmel.com>
References: <1461074628-20224-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <CACRpkdbxu4guLjaaMrQ5h1H=4nByuzbSc-aOBdb2S7m8BfZ5Hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2016 at 4:03 PM, Ludovic Desroches
<ludovic.desroches@atmel.com> wrote:

> The default configuration of a pin is often with a value in the
> pull-up/down field at chip reset. So, even if the internal logic of the
> controller prevents writing a configuration with pull-up and pull-down at
> the same time, we must ensure explicitly this condition before writing the
> register.
>
> This was leading to a pull-down condition not taken into account for
> instance.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Fixes: 776180848b57 ("pinctrl: introduce driver for Atmel PIO4 controller")
> Cc: stable at vger.kernel.org #v4.4 and later

Patch applied for fixes with the ACKs.

Yours,
Linus Walleij
