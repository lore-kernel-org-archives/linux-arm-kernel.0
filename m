From: manabian@gmail.com (Joachim Eastwood)
Date: Fri, 4 Dec 2015 19:37:52 +0100
Subject: [PATCH] clocksource: correct pr_err() output format
In-Reply-To: <1449036128-19968-1-git-send-email-vz@mleia.com>
References: <1449036128-19968-1-git-send-email-vz@mleia.com>
Message-ID: <CAGhQ9Vw-Qn7WJXQbXMcopA_TD2-jU3Xk+okn_iC9ixG12h0RgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 December 2015 at 07:02, Vladimir Zapolskiy <vz@mleia.com> wrote:
> If by some reason timerclk is not available, both clockevent and
> clocksource initializations correctly exit, but output of errno to
> kernel log buffer may be confusing:
>
>   lpc32xx_clk_init: failed to map system control block registers
>   lpc32xx_clocksource_init: clock get failed (4294966779)
>   lpc32xx_clockevent_init: clock get failed (4294966779)
>
> Use signed integer output in the correspondent pr_err() string formats:
>
>   lpc32xx_clocksource_init: clock get failed (-517)
>   lpc32xx_clockevent_init: clock get failed (-517)
>
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>

Acked-by: Joachim Eastwood <manabian@gmail.com>


regards,
Joachim Eastwood
