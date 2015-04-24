From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 24 Apr 2015 09:57:17 +0200
Subject: [PATCH 0/5] PM / clock_ops: provide default runtime ops and
 cleanup users
In-Reply-To: <1429777993-11702-1-git-send-email-rnayak@codeaurora.org>
References: <1429777993-11702-1-git-send-email-rnayak@codeaurora.org>
Message-ID: <CAPDyKFpAm+DK4SUK_Oc7Fb+jEEQvO3355qWp52nmkJs2YX5T4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 April 2015 at 10:33, Rajendra Nayak <rnayak@codeaurora.org> wrote:
> Most users of PM clocks do the exact same thing in runtime callbacks.
> Provide default callbacks and cleanup the existing users (keystone/davinci
> /omap1/sh)
>
> Rajendra Nayak (5):
>   PM / clock_ops: Provide default runtime ops to users
>   arm: keystone: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
>   arm: omap1: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
>   arm: davinci: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
>   drivers: sh: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
>
>  arch/arm/mach-davinci/pm_domain.c  | 32 +-------------------------
>  arch/arm/mach-keystone/pm_domain.c | 33 +-------------------------
>  arch/arm/mach-omap1/pm_bus.c       | 37 ++----------------------------
>  drivers/base/power/clock_ops.c     | 38 ++++++++++++++++++++++++++++++
>  drivers/sh/pm_runtime.c            | 47 ++------------------------------------
>  include/linux/pm_clock.h           | 10 ++++++++
>  6 files changed, 54 insertions(+), 143 deletions(-)

I guess you don't need more acks/reviewed by for this patchset. Still,
and also for my own reference.

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
