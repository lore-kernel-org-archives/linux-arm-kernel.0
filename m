From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 2 Mar 2015 13:28:36 +0100
Subject: [PATCH V2 0/8] [media] exynos-gsc: Fixup PM support
In-Reply-To: <1421673760-2600-1-git-send-email-ulf.hansson@linaro.org>
References: <1421673760-2600-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CAPDyKFpC4Ytd7j7MRV6G27Be7TphKBc-7ZyVBveAbiHB8VMt+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 January 2015 at 14:22, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Changes in v2:
>         - Rebase patches.
>         - Adapt to changes for the PM core. Especially, the Kconfig option for
>           CONFIG_PM_RUNTIME has been removed and the runtime PM core is now
>           build for CONFIG_PM.
>
> This patchset fixup the PM support and adds some minor improvements to
> potentially save some more power at runtime PM suspend.
>
>
> Ulf Hansson (8):
>   [media] exynos-gsc: Simplify clock management
>   [media] exynos-gsc: Convert gsc_m2m_resume() from int to void
>   [media] exynos-gsc: Make driver functional when CONFIG_PM is unset
>   [media] exynos-gsc: Make runtime PM callbacks available for CONFIG_PM
>   [media] exynos-gsc: Fixup clock management at ->remove()
>   [media] exynos-gsc: Do full clock gating at runtime PM suspend
>   [media] exynos-gsc: Make system PM callbacks available for
>     CONFIG_PM_SLEEP
>   [media] exynos-gsc: Simplify system PM
>
>  drivers/media/platform/exynos-gsc/gsc-core.c | 183 +++++++++++----------------
>  drivers/media/platform/exynos-gsc/gsc-core.h |   3 -
>  2 files changed, 72 insertions(+), 114 deletions(-)
>
> --
> 1.9.1
>

I guess you guys have been busy, but it would be nice to get some
feedback of these patches.

Kind regards
Uffe
