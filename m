From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 14 Jan 2014 16:01:26 +0100
Subject: [GIT PULL] clockevents/clocksources: 3.13 fixes
In-Reply-To: <52C14E45.5040403@linaro.org>
References: <52C14E45.5040403@linaro.org>
Message-ID: <52D55146.8010006@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/30/2013 11:43 AM, Daniel Lezcano wrote:
>
> Hi Thomas and Ingo,
>
> here is a pull request for a single fix for 3.13. It is based on the
> latest timers/urgent update.
>
>   * Soren Brinkmann fixed the cadence_ttc driver where a call to
> clk_get_rate happens in an interrupt context. More precisely in an IPI
> when the broadcast timer is initialized for each cpu in the cpuidle driver

Hi Thomas and Ingo,

just a head up for this PR. It has been sent right before the PR for 
3.14, so I wanted to me sure you did not missed it.

Thanks
   -- Daniel

>
> Thanks
>    -- Daniel
>
> The following changes since commit
> b0031f227e47919797dc0e1c1990f3ef151ff0cc:
>
>    Merge tag 's2mps11-build' of
> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator
> (2013-12-17 12:57:36 -0800)
>
> are available in the git repository at:
>
>
>    git://git.linaro.org/people/daniel.lezcano/linux.git
> clockevents/3.13-fixes
>
> for you to fetch changes up to c1dcc927dae01dfd4904ee82ce2c00b50eab6dc3:
>
>    clocksource: cadence_ttc: Fix mutex taken inside interrupt context
> (2013-12-30 11:32:24 +0100)
>
> ----------------------------------------------------------------
> Soren Brinkmann (1):
>        clocksource: cadence_ttc: Fix mutex taken inside interrupt context
>
>   drivers/clocksource/cadence_ttc_timer.c |   21 +++++++++++++--------
>   1 file changed, 13 insertions(+), 8 deletions(-)
>
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
