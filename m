From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 24 May 2013 09:44:55 +0200
Subject: [PATCH] ARM: ux500: Only configure wake-up reasons on ux500 based
 platforms
In-Reply-To: <1368702935-25599-1-git-send-email-lee.jones@linaro.org>
References: <1368702935-25599-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZjC7nFxsWkED6FvCOxdA1oQVuB+Tz8DZWM+iQDi6zjWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 1:15 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Multiplatform calls all enabled platforms' initcalls. In the
> ux500_idle_init() initcall we call into the DBx500-PRCMU which in turn
> executes some ux500 specific register reads/writes. When running on
> some !ux500 platforms this ends up causing a kernel Oops. This patch
> ensures the PRCMU call is only invoked when running on ux500 based
> platforms.
>
> Reported-by: Rob Herring <rob.herring@calxeda.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied for ux500 fixes.

Hm, again and again I get so confused by this, don't you say
"wakeup CAUSE" rather than "wakeup REASON"?

Maybe I don't know the anglo saxon well enough...

Yours,
Linus Walleij
