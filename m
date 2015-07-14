From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Jul 2015 15:35:41 +0200
Subject: [PATCH 33/41] clocksource: integrator: Migrate to new 'set-state'
 interface
In-Reply-To: <5e78d6f43d81c4f08939a7a6a585be019a1f2e1f.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
 <5e78d6f43d81c4f08939a7a6a585be019a1f2e1f.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <CACRpkdbyzAguwxpVudVnxfChTZ2-tCr39o=Y=5foBY8qkPuC1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 12:54 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> Migrate integrator driver to the new 'set-state' interface provided by
> clockevents core, the earlier 'set-mode' interface is marked obsolete
> now.
>
> This also enables us to implement callbacks for new states of clockevent
> devices, for example: ONESHOT_STOPPED.
>
> For oneshot mode the clkevt device was first getting disabled by
> clearing TIMER_CTRL_ENABLE bits in TIMER_CTRL register, followed by
> clearing TIMER_CTRL_PERIODIC bit. Both these are done with a single
> write operation now.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
