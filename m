From: shc_work@mail.ru (Alexander Shiyan)
Date: Thu, 30 Aug 2012 21:02:10 +0400
Subject: [PATCH] ARM: clps711x: convert to clocksource/clockevents
In-Reply-To: <1346344678-18248-1-git-send-email-linus.walleij@linaro.org>
References: <1346344678-18248-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20120830210210.55e0899d.shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 30 Aug 2012 18:37:58 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> This converts the ageing clps711x timer driver to the modern
> clocksource/clockevent API.
The patch does not account for the changes that I sent to the mailing list
recently, where I did support different clock frequencies for the processor.

> This was blind-coded using the datasheet, it'd be great if someone
> who has this machine could test it.
...
> +	/* Set both timers to 512 kHz */
The patch uses a second timer, which does not allow its use for other purposes,
I can not test the functionality of the device in this case, unfortunately.

I have also tried to do something like this without using additional processor
resources, but not yet brought to the finish line yet.

-- 
Alexander Shiyan <shc_work@mail.ru>
