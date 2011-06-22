From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 22 Jun 2011 15:06:16 -0400 (EDT)
Subject: [PATCH 1/3] leds: create a trigger for ARM CPU activity
In-Reply-To: <1308763983-24749-1-git-send-email-linus.walleij@stericsson.com>
References: <1308763983-24749-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <alpine.LFD.2.00.1106221446350.2142@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 22 Jun 2011, Linus Walleij wrote:

> From: Linus Walleij <linus.walleij@linaro.org>
> 
> Attempting to consolidate the ARM LED code, this removes the
> custom RealView LED trigger code to turn LEDs on and off in
> response to CPU activity and replace it with a standard trigger.
> It uses the existing kernel hooks deep inside <asm/leds.h> to
> get CPU activity.
> 
> Cc: Bryan Wu <bryan.wu@canonical.com>
> Cc: Richard Purdie <rpurdie@rpsys.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Looks nice to me.  You don't handle the led_timer event, but since there 
is already a ledtrig-heartbeat trigger available, the conversion to the 
generic LED API can use that by default.

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Converting all remaining users of leds_event would be a great thing too.


Nicolas
