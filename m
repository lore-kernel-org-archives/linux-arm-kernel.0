From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 4 Apr 2014 14:35:04 +0530
Subject: [PATCH 13/17] ARM: exynos: cpuidle: Move clock setup to pm.c
In-Reply-To: <1396597683-6969-14-git-send-email-daniel.lezcano@linaro.org>
References: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
 <1396597683-6969-14-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <CAKohpomAC5O+i=h+X-6UYjFOf3C91jjOYizG_DPR=GhmCh95cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 April 2014 13:17, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> One more step is moving the clock ratio setting at idle time in pm.c
>
> The macro names have been changed to be consistent with the other macros
> name in the file.
>
> Note, the clock divider was working only when cpuidle was enabled because it
> was in its init routine. With this change, the clock divider is set in the pm's
> init routine, so it will also operate when the cpuidle driver is not set, which
> is good.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-exynos/cpuidle.c |   54 ---------------------------------------
>  arch/arm/mach-exynos/pm.c      |   55 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 54 insertions(+), 55 deletions(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
