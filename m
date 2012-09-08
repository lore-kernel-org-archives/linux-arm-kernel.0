From: olof@lixom.net (Olof Johansson)
Date: Fri, 7 Sep 2012 20:34:22 -0700
Subject: [PATCH 1/4] ARM: ks-8695: merge the timer header into the timer
 driver
In-Reply-To: <1346264802-20306-1-git-send-email-linus.walleij@linaro.org>
References: <1346264802-20306-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CAOesGMiyd8xnXSMbeHXEed7r-PR2CnNcp=nMA3W5sM6Q-3p1xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2012 at 11:26 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> This <mach/regs-timer.h> is broadcasted in the entire kernel for
> no good reason, since it's only used by the timer driver. Merge
> it into the driver.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Actually, it's also included in the watchdog timer that is only
enabled on the acs5k defconfigs today, not on the main ks8695 one :(

drivers/watchdog/ks8695_wdt.c:27:29: fatal error: mach/regs-timer.h:
No such file or directory


-Olof
