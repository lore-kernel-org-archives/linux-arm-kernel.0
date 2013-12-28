From: olof@lixom.net (Olof Johansson)
Date: Sat, 28 Dec 2013 15:09:16 -0800
Subject: [PATCH 03/11] ARM: EXYNOS: local regs-pmu.h header file
In-Reply-To: <116101cefb1e$69ddfe70$3d99fb50$@kernel.org>
References: <116101cefb1e$69ddfe70$3d99fb50$@kernel.org>
Message-ID: <CAOesGMjJXodfZUSwHWdYgJsTWL4FANxXnP519B0AUiwpEn4bQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On Tue, Dec 17, 2013 at 3:52 AM,  <kgene@kernel.org> wrote:
> From: Kukjin Kim <kgene.kim@samsung.com>
>
> This moves regs-pmu.h file into mach-exynos directory.
>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-exynos/common.c                      |    3 ++-
>  arch/arm/mach-exynos/cpuidle.c                     |    2 +-
>  arch/arm/mach-exynos/hotplug.c                     |    2 +-
>  arch/arm/mach-exynos/mach-exynos5-dt.c             |    2 +-
>  arch/arm/mach-exynos/platsmp.c                     |    2 +-
>  arch/arm/mach-exynos/pm.c                          |    2 +-
>  arch/arm/mach-exynos/pm_domains.c                  |    3 ++-
>  arch/arm/mach-exynos/pmu.c                         |    2 +-
>  arch/arm/mach-exynos/{include/mach => }/regs-pmu.h |    0
>  9 files changed, 10 insertions(+), 8 deletions(-)
>  rename arch/arm/mach-exynos/{include/mach => }/regs-pmu.h (100%)

This looks OK, but when you committed, you did the move of the include
file in another commit (e44de221d3ddb99387b04cfd49483bcd05daa6fb).
That means that between that commit and this patch, there's build
breakage. Please try to avoid that in the future since if something
needs to be bisected near here it can cause problems.


-Olof
