From: narmstrong@baylibre.com (Neil Armstrong)
Date: Sat, 30 Jan 2016 15:52:12 +0100
Subject: [PATCH 0/4] pwm: omap-dmtimer: fix period/duty_cycle calculation
In-Reply-To: <1454128014-22866-1-git-send-email-drivshin.allworx@gmail.com>
References: <1454128014-22866-1-git-send-email-drivshin.allworx@gmail.com>
Message-ID: <CAA3gFWsc6YxEvaFW2MJ2D-xBZqEzLOJne9AHZ6zBK3h3THy0CA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-01-30 5:26 GMT+01:00 David Rivshin (Allworx) <drivshin.allworx@gmail.com>:
> From: David Rivshin <drivshin@allworx.com>
>
> When using a short PWM period (approaching the min of 2/clk_rate),
> pwm-omap-dmtimer does not produce accurate results. In the worst case a
> requested period of 2/clk_rate would result in a real period of 4/clk_rate
> instead. This is a series includes a fix for that problem, as well as
> other related improvements, and is based on the current linux-pwm/for-next
> tip.
>
> I have tested on a Sitara AM335x platform, using a scope to verify the
> output with a variety of periods and duty cycles. This includes a PWM
> rate up clk_rate/2 with 50% duty cycle (e.g. generating fclk/2) with
> both 32768Hz and 24MHz fclks. I do not have an OMAP4 board to test with,
> although appropriate sections in the the reference manuals appear
> substantially the same, so I believe the changes are equally correct
> there.
>
> Note that the OMAP4 TRMs do effectively state that the maximum PWM
> rate is clk_rate/4, so at very fast PWM rates the behavior may not be
> as reliable as I observed with Sitara. Although I suspect that it's
> the same module and will also work, at least under some circumstances.
> If anyone with OMAP4 hardware and a scope is so inclined, I would be
> curious to know the results.

Hi David,

Thanks for the work, it seems all good, I'll test them on my side the
next days, but this work needed to be done for sure !

The only OMAP4 HW I have is a Pandaboard and it's very difficult to
get the timer outputs...


Neil
