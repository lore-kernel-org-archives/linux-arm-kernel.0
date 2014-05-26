From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 26 May 2014 11:10:02 +0530
Subject: [PATCH v2] cpufreq: exynos: Fix driver compilation with
 ARCH_MULTIPLATFORM
In-Reply-To: <1400858533-4327-1-git-send-email-t.figa@samsung.com>
References: <1400670752-673-1-git-send-email-t.figa@samsung.com>
 <1400858533-4327-1-git-send-email-t.figa@samsung.com>
Message-ID: <CAKohponMVKg118YxGHohqcHGmnnZmU3G2-=EJqz+RD0hH5o4tA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 May 2014 20:52, Tomasz Figa <t.figa@samsung.com> wrote:
> Currently Exynos cpufreq drivers rely on globally mapped clock
> controller registers to configure frequency of CPU cores. This is
> obviously wrong and will be removed in near future, but to enable
> support for multi-platform builds without introducing a regression it
> needs to be worked around.
>
> This patch hacks the code to look for clock controller node in device
> tree and map its registers using of_iomap(), instead of relying on
> global mapping, so dependencies on platform headers are removed and the
> driver can compile again with multiplatform support.
>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  drivers/cpufreq/Kconfig.arm          |  6 ++---
>  drivers/cpufreq/exynos-cpufreq.c     |  2 --
>  drivers/cpufreq/exynos-cpufreq.h     | 30 ++++++++++++-------------
>  drivers/cpufreq/exynos4210-cpufreq.c | 39 +++++++++++++++++++++++++++-----
>  drivers/cpufreq/exynos4x12-cpufreq.c | 40 ++++++++++++++++++++++++++++-----
>  drivers/cpufreq/exynos5250-cpufreq.c | 43 +++++++++++++++++++++++++++++-------
>  6 files changed, 119 insertions(+), 41 deletions(-)

Looks fine..

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
