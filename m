From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 20 Mar 2014 14:54:45 +0900
Subject: [PATCH Resend 1/3] ARM: EXYNOS: Consolidate Kconfig entries
In-Reply-To: <1395224705-2935-1-git-send-email-sachin.kamat@linaro.org>
References: <1395224705-2935-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <02f701cf4400$e561e2c0$b025a840$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sachin Kamat wrote:
> 
> Instead of repeating the Kconfig entries for every SoC, move them under
> ARCH_EXYNOS4 and 5 and move the entries common to both 4 and 5 under
> ARCH_EXYNOS. Also, since the individual SoCs do not have any specific
> machine/platform code, keep them as boolean symbols instead of user
> selectable and select them from Exynos4 and 5 config symbols. Individual
> SoC symbols can be removed eventually once the driver Kconfig dependencies
> on these symbols are removed.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Acked-by: Tomasz Figa <t.figa@samsung.com>
> ---
> This is a resend of the series rebased on top of latest linux-next and
> Tomasz Figa's PM consolidation series 1 and 2.
> ---
>  arch/arm/Kconfig             |   10 +++++
>  arch/arm/mach-exynos/Kconfig |   89
+++++++++++---------------------------
> ----
>  2 files changed, 33 insertions(+), 66 deletions(-)
> 
Hmm...I'm still thinking whether we don't need to select some specific
Exynos SoCs. Because actually we're implement/develop some features based on
mainline kernel and sometimes the features are not valid on all of Exynos4
or Exynos5. Even though they are not in mainline, for mass product it's true
that Samsung needs to do it. It's another thing we have a plan for them or
not.

So in my opinion, basically consolidation something is usually good but it's
not always good so we need to provide a way to use one of both.

Thanks,
Kukjin
