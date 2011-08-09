From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 9 Aug 2011 14:12:13 +0200
Subject: [RFC PATCH 08/12] ARM: local timers: switch ux500 to standalone
	smp_twd
In-Reply-To: <1312886814-15627-9-git-send-email-marc.zyngier@arm.com>
References: <1312886814-15627-1-git-send-email-marc.zyngier@arm.com>
	<1312886814-15627-9-git-send-email-marc.zyngier@arm.com>
Message-ID: <4E41241D.7020907@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/2011 12:46 PM, Marc Zyngier wrote:
> Convert the ux500 platforms to the standalone version of smp_twd.c.
> Since the timer calibration code requires another timer to be up
> and running, the actual initialisation is left to the late_timer_init
> hook.
>
> Cc: Linus Walleij<linus.walleij@stericsson.com>
> Signed-off-by: Marc Zyngier<marc.zyngier@arm.com>
>    

So it switch to ioremap():ing the TWD too.
Seems like a pretty good idea.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
