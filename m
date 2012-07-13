From: marex@denx.de (Marek Vasut)
Date: Fri, 13 Jul 2012 19:32:34 +0200
Subject: [PATCH] ARM: disable interrupt before spinning endlessly
In-Reply-To: <1341824988-18615-1-git-send-email-shawn.guo@linaro.org>
References: <1341824988-18615-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <201207131932.34530.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> The CPU will endlessly spin at the end of machine_halt and
> machine_restart calls.  However, this will lead to a soft lockup
> warning after about 20 seconds, if CONFIG_LOCKUP_DETECTOR is enabled,
> as system timer is still alive.
> 
> Disable interrupt before going to spin endlessly, so that the lockup
> warning will never be seen.
> 
> Reported-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/kernel/process.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

I just got back from a conference, I'd gladly test. But my mx28 doesn't boot at 
all with latest -next. Any idea why?

Best regards,
Marek Vasut
