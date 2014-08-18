From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Mon, 18 Aug 2014 16:03:57 +0530
Subject: [PATCH v3 0/2] Refactor the pm code to use DT based lookup
In-Reply-To: <1407412789-1919-1-git-send-email-vikas.sajjan@samsung.com>
References: <1407412789-1919-1-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <CAGm_ybjZBfmpv2t5kuCvd7F+vMh4mZK+1ULdXuZCRBtEjXMQuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

On Thu, Aug 7, 2014 at 5:29 PM, Vikas Sajjan <vikas.sajjan@samsung.com> wrote:
> Refactoring the pm.c to avoid using "soc_is_exynos" checks,
> instead use the DT based lookup.
>
> While at it, move exynos5250 specific disabling of JPEG USE_RETENTION to pmu.c
>
> changes since v2:
>         - Addressed Tomasz Figa's comments to unify the functions for exynos4
>         and exynos5250.
>         - Added new patch to move exynos5250 specific disabling of
>                 JPEG USE_RETENTION to pmu.c
>         - Addressed comment from Thomas Abraham.
> changes since v1:
>         - Address Kukjin Kim comments to respin this patch separately from
>                 http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/272574.html
>         - removed panic, returned if no PMU node found and added check in exynos_wkup_irq.
>
> Rebased on Kukjin Kim's tree, for-next branch
>         https://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/log/?h=for-next
>
> Vikas Sajjan (2):
>   ARM: EXYNOS: Move Disabling of JPEG USE_RETENTION for exynos5250 to
>     pmu.c
>   ARM: EXYNOS: Refactor the pm code to use DT based lookup
>
>  arch/arm/mach-exynos/pm.c       |  173 ++++++++++++++++++++++++++++-----------
>  arch/arm/mach-exynos/pmu.c      |    6 ++
>  arch/arm/mach-exynos/regs-pmu.h |    1 +
>  3 files changed, 132 insertions(+), 48 deletions(-)


Anymore  comments on this series...


>
> --
> 1.7.9.5
>
