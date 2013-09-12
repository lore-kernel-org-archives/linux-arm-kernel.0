From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 12 Sep 2013 16:57:28 +0530
Subject: [PATCH v2 0/4] Remodel Tegra cpufreq driver to support Tegra
 series SoCs
In-Reply-To: <1378985091-9447-1-git-send-email-bilhuang@nvidia.com>
References: <1378985091-9447-1-git-send-email-bilhuang@nvidia.com>
Message-ID: <CAKohpom-8abJCL_VrdvowmKUkfyEw0svne-RpXFhhO1AH6NPew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 September 2013 16:54, Bill Huang <bilhuang@nvidia.com> wrote:
> This patch series remodel Tegra cpufreq driver to make it more easy to
> add new SoC support, in addition to that, adding probe function in the
> driver to let probe defer can be used to control init sequence when we
> going to support DVFS.
>
> Changes since v1:
>
> - Split up patches.
> - Split configuration-time data out of structure "tegra_cpufreq_data".
> - Bug fixes.
>
> Bill Huang (4):
>   cpufreq: tegra: Call tegra_cpufreq_init() specifically in machine
>     code
>   cpufreq: tegra: Remove not used header files and clean up codes
>   cpufreq: tegra: Re-model Tegra cpufreq driver
>   ARM: tegra: defconfig updates
>
>  arch/arm/configs/tegra_defconfig  |    1 +
>  arch/arm/mach-tegra/common.c      |    2 +
>  drivers/cpufreq/Kconfig.arm       |    8 +-
>  drivers/cpufreq/Makefile          |    1 +
>  drivers/cpufreq/tegra-cpufreq.c   |  194 +++++++++++++++++--------------------
>  drivers/cpufreq/tegra-cpufreq.h   |   42 ++++++++
>  drivers/cpufreq/tegra20-cpufreq.c |  138 ++++++++++++++++++++++++++
>  include/linux/tegra-soc.h         |   11 ++-
>  8 files changed, 290 insertions(+), 107 deletions(-)
>  create mode 100644 drivers/cpufreq/tegra-cpufreq.h
>  create mode 100644 drivers/cpufreq/tegra20-cpufreq.c

I haven't gone deeper into these yet, but there are some cleaup
patches that I have prepared/posted earlier, which will be queued
by Rafael soon.. And after that you would be required to rebase
your stuff on top of it..  As there would be many conflicts..

--
viresh
