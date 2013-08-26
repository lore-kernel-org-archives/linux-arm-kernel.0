From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 26 Aug 2013 19:35:24 +0530
Subject: [PATCH] cpufreq: imx6q: Fix clock enable balance
In-Reply-To: <1377517716-27470-1-git-send-email-s.hauer@pengutronix.de>
References: <1377517716-27470-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CAKohponSYhBBBjxUme2bmVNW3HZfWuU=_OeL5HuA6nnVCit3tA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 August 2013 17:18, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> For changing the cpu frequency the i.MX6q has to be switched to some
> intermediate clock during the PLL reprogramming. The driver tries
> to be clever to keep the enable count correct but gets it wrong. If
> the cpufreq is increased it calls clk_disable_unprepare twice
> on pll2_pfd2_396m. This puts all other devices which get their clock
> from pll2_pfd2_396m into a nonworking state.
>
> Fix this by removing the clk enabling/disabling altogether since the
> clk core will do this automatically during a reparent.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 17 -----------------
>  1 file changed, 17 deletions(-)

Applied.
