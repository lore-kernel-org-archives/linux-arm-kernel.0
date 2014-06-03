From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 3 Jun 2014 09:57:14 +0530
Subject: [PATCH] ARM: Remove ARCH_HAS_CPUFREQ config option
In-Reply-To: <1401746847-3193-1-git-send-email-sboyd@codeaurora.org>
References: <1401746847-3193-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <CAOh2x==wsy2_+GygS03snFN_YOar3eHi7v1a-jNdsQYoWCAZsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 3, 2014 at 3:37 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> This config exists entirely to hide the cpufreq menu from the
> kernel configuration unless a platform has selected it. Nothing
> is actually built if this config is 'Y' and it just leads to
> more patches that add a select under a platform Kconfig so that
> some other CPUfreq option can be chosen. Let's remove the
> option so that we can always enable CPUfreq drivers on ARM
> platforms.
>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  arch/arm/Kconfig               | 18 ------------------
>  arch/arm/mach-davinci/Kconfig  |  1 -
>  arch/arm/mach-highbank/Kconfig |  1 -
>  arch/arm/mach-imx/Kconfig      |  3 ---
>  arch/arm/mach-mvebu/Kconfig    |  1 -
>  arch/arm/mach-omap2/Kconfig    |  1 -
>  arch/arm/mach-shmobile/Kconfig |  2 --
>  arch/arm/mach-spear/Kconfig    |  1 -
>  arch/arm/mach-tegra/Kconfig    |  1 -
>  arch/arm/mach-ux500/Kconfig    |  1 -
>  arch/arm/mach-vexpress/Kconfig |  1 -
>  arch/arm/mach-vt8500/Kconfig   |  1 -
>  arch/arm/mach-zynq/Kconfig     |  1 -
>  13 files changed, 33 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

While you are at it, please see if you can also fix unicore as well.
