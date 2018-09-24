From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 24 Sep 2018 08:28:28 +0200
Subject: [PATCH 1/2] clocksource/drivers: Unify the names to timer-* format
In-Reply-To: <1537762569-18657-1-git-send-email-daniel.lezcano@linaro.org>
References: <1537762569-18657-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20180924062828.4yh3aumcuiihojgu@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2018 at 06:15:17AM +0200, Daniel Lezcano wrote:
> In order to make some housekeeping in the directory, this patch renames
> drivers to the timer-* format in order to unify their names.
> 
> There is no functional changes.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  MAINTAINERS                               |  10 +-
>  drivers/clocksource/Makefile              |  26 +-
>  drivers/clocksource/cadence_ttc_timer.c   | 543 ------------------------------
>  drivers/clocksource/fsl_ftm_timer.c       | 376 ---------------------
>  drivers/clocksource/owl-timer.c           | 173 ----------
>  drivers/clocksource/qcom-timer.c          | 258 --------------
>  drivers/clocksource/time-armada-370-xp.c  | 416 -----------------------
>  drivers/clocksource/time-efm32.c          | 287 ----------------
>  drivers/clocksource/time-lpc32xx.c        | 314 -----------------
>  drivers/clocksource/time-orion.c          | 192 -----------
>  drivers/clocksource/time-pistachio.c      | 218 ------------
>  drivers/clocksource/timer-armada-370-xp.c | 416 +++++++++++++++++++++++
>  drivers/clocksource/timer-cadence-ttc.c   | 543 ++++++++++++++++++++++++++++++
>  drivers/clocksource/timer-efm32.c         | 287 ++++++++++++++++
>  drivers/clocksource/timer-fsl-ftm.c       | 376 +++++++++++++++++++++
>  drivers/clocksource/timer-lpc32xx.c       | 314 +++++++++++++++++
>  drivers/clocksource/timer-orion.c         | 192 +++++++++++
>  drivers/clocksource/timer-owl.c           | 173 ++++++++++
>  drivers/clocksource/timer-pistachio.c     | 218 ++++++++++++
>  drivers/clocksource/timer-qcom.c          | 258 ++++++++++++++
>  drivers/clocksource/timer-versatile.c     |  44 +++
>  drivers/clocksource/timer-vf-pit.c        | 204 +++++++++++
>  drivers/clocksource/timer-vt8500.c        | 168 +++++++++
>  drivers/clocksource/timer-zevio.c         | 218 ++++++++++++
>  drivers/clocksource/versatile.c           |  44 ---
>  drivers/clocksource/vf_pit_timer.c        | 204 -----------
>  drivers/clocksource/vt8500_timer.c        | 168 ---------
>  drivers/clocksource/zevio-timer.c         | 218 ------------
>  28 files changed, 3429 insertions(+), 3429 deletions(-)

Wow, with git format-patch -M this should look much smaller and so
easier to review.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
