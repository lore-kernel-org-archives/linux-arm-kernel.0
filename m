From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 26 Jun 2011 13:10:48 +0200
Subject: [PATCH 3/4] mach-realview: retire custom LED code
In-Reply-To: <1309039804-659-4-git-send-email-bryan.wu@canonical.com>
References: <1309039804-659-1-git-send-email-bryan.wu@canonical.com>
	<1309039804-659-4-git-send-email-bryan.wu@canonical.com>
Message-ID: <BANLkTinx0uFE-ODhTcpsJdE5KSq_C8aB6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/6/26 Bryan Wu <bryan.wu@canonical.com>:

> This replaces the custom LED trigger code in mach-realview with
> some overarching platform code for the plat-versatile family that
> will lock down LEDs 2 thru 5 for CPU activity indication. The
> day we have 8 core ARM systems the plat-versatile code will have
> to become more elaborate.
>
> Tested on RealView PB11MPCore by invoking four different CPU
> hogs (yes > /dev/null&) and see the LEDs go on one at a time.
> They all go off as the hogs are killed. Tested on the PB1176
> as well - just one activity led (led 2) goes on and off with
> CPU activity.
>
> (bryan.wu at canonical.com: use ledtrig-cpu instead of ledtrig-arm-cpu)
>
> Cc: Richard Purdie <rpurdie@rpsys.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>

This is good, especially the KConfig fixups, but also include Pawel Moll's
Acked-by on these patches.

Linus Walleij
