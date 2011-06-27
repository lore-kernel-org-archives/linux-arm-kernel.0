From: bryan.wu@canonical.com (Bryan Wu)
Date: Mon, 27 Jun 2011 14:00:25 +0800
Subject: [PATCH 2/4] ARM: use new LEDS CPU trigger stub to replace old one
In-Reply-To: <BANLkTinCWcjNOR6uoGno1riRb+LBZLJ+Gg@mail.gmail.com>
References: <1309039804-659-1-git-send-email-bryan.wu@canonical.com>
	<1309039804-659-3-git-send-email-bryan.wu@canonical.com>
	<BANLkTinCWcjNOR6uoGno1riRb+LBZLJ+Gg@mail.gmail.com>
Message-ID: <BANLkTimDfs0SG7ZYAHcMqMSV1N7gheo2Rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 26, 2011 at 7:08 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> Hi Bryan, notice that this:
>
> 2011/6/26 Bryan Wu <bryan.wu@canonical.com>:
>
>> - ? ? ? ? ? ? ? leds_event(led_idle_start);
>> + ? ? ? ? ? ? ? ledtrig_cpu(CPU_LED_IDLE_START);
> (...)
>> - ? ? ? ? ? ? ? leds_event(led_idle_end);
>> + ? ? ? ? ? ? ? ledtrig_cpu(CPU_LED_IDLE_END);
>
> That breaks all the old users of the CPU activity LEDs.
>
> I only fixed up RealView and Versatile!
>
> grep -r led_idle_start arch/arm/
>
> Gives you a hint that you also have to retire custom LEDs from
> orion, omap, at91, footbridge, sa1100, ks8695, shark, clps711x,
> pxa and omap1.
>
> You have to write a patch each an every one of these, and
> since they all are already using that mechanism actively
> you need to select the LED trigger in their Kconfig.
>

No problem, I will clean them up soon.

Thanks,
-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
