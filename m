From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 26 Jun 2011 13:08:01 +0200
Subject: [PATCH 2/4] ARM: use new LEDS CPU trigger stub to replace old one
In-Reply-To: <1309039804-659-3-git-send-email-bryan.wu@canonical.com>
References: <1309039804-659-1-git-send-email-bryan.wu@canonical.com>
	<1309039804-659-3-git-send-email-bryan.wu@canonical.com>
Message-ID: <BANLkTinCWcjNOR6uoGno1riRb+LBZLJ+Gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bryan, notice that this:

2011/6/26 Bryan Wu <bryan.wu@canonical.com>:

> - ? ? ? ? ? ? ? leds_event(led_idle_start);
> + ? ? ? ? ? ? ? ledtrig_cpu(CPU_LED_IDLE_START);
(...)
> - ? ? ? ? ? ? ? leds_event(led_idle_end);
> + ? ? ? ? ? ? ? ledtrig_cpu(CPU_LED_IDLE_END);

That breaks all the old users of the CPU activity LEDs.

I only fixed up RealView and Versatile!

grep -r led_idle_start arch/arm/

Gives you a hint that you also have to retire custom LEDs from
orion, omap, at91, footbridge, sa1100, ks8695, shark, clps711x,
pxa and omap1.

You have to write a patch each an every one of these, and
since they all are already using that mechanism actively
you need to select the LED trigger in their Kconfig.

Thanks,
Linus Walleij
