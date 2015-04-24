From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Fri, 24 Apr 2015 16:41:49 +0200
Subject: [PATCH 0/5] PM / clock_ops: provide default runtime ops and
 cleanup users
In-Reply-To: <1429777993-11702-1-git-send-email-rnayak@codeaurora.org>
References: <1429777993-11702-1-git-send-email-rnayak@codeaurora.org>
Message-ID: <2234398.3O5UMXvvlN@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, April 23, 2015 02:03:08 PM Rajendra Nayak wrote:
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

It is not particularly clear to me who is supposed to apply this series, but
I can do that if people don't have problems with that.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
