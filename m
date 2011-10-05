From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 5 Oct 2011 17:51:11 +0900
Subject: [GIT PULL] Samsung board-2 for v3.2
In-Reply-To: <019b01cc8298$846170c0$8d245240$%kim@samsung.com>
References: <019b01cc8298$846170c0$8d245240$%kim@samsung.com>
Message-ID: <CAH9JG2XCeymVK8WjetnjWa3qumwJqmXu7wz_K2hX_u+LBjQTjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

As you decide to rename the mach name, how to change the board name together?
Historically samsung use the "mach-" prefix for board name, but others
are use the "board-" prefix.
So let's use the same convention as others?

How do you think?

Thank you,
Kyungmin Park

On Tue, Oct 4, 2011 at 10:21 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Hi Arnd,
>
> This is a second Samsung board stuff for v3.2 and includes new board,
> SMDK4412.
>
> Please pull from:
> ?git://github.com/kgene/linux-samsung.git next-samsung-board-2
>
> As a note, since supporting SMDK4412 needs previous next-samsung-board
> branch so this is based on next-samsung-board which has been already merged
> into arm-soc and this includes converting boot_params to atag_offset for
> adding/changing boards in this time.
>
> If any problems, please let me know.
>
> One more as a note, the next-samsung-devel and next-samsung-devel-2 will be
> sent to you soon after testing ;)
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
> The following changes since commit 2520123382e97271e932377c83bca010c265be55:
>
> ?Merge branch 'next-samsung-board-v3.1' into next-samsung-board (2011-09-16
> 17:13:09 +0900)
>
> are available in the git repository at:
>
> ?git://github.com/kgene/linux-samsung.git next-samsung-board-2
>
> Changhwan Youn (7):
> ? ? ?ARM: EXYNOS4: Add support PPI in external GIC
> ? ? ?ARM: EXYNOS4: Add support MCT PPI for EXYNOS4212
> ? ? ?ARM: EXYNOS4: Add support new EXYNOS4412 SoC
> ? ? ?ARM: EXYNOS4: Add support clock for EXYNOS4412
> ? ? ?ARM: EXYNOS4: Add functions for gic interrupt handling
> ? ? ?ARM: EXYNOS4: Add MCT support for EXYNOS4412
> ? ? ?ARM: EXYNOS4: Add support SMDK4412 Board
>
> Tushar Behera (1):
> ? ? ?ARM: EXYNOS4: convert boot_params to atag_offset
>
> ?arch/arm/mach-exynos4/Kconfig ? ? ? ? ? ? ? ? ? ? ?| ? 14 ++
> ?arch/arm/mach-exynos4/Makefile ? ? ? ? ? ? ? ? ? ? | ? ?3 +-
> ?arch/arm/mach-exynos4/clock.c ? ? ? ? ? ? ? ? ? ? ?| ? ?4 +-
> ?arch/arm/mach-exynos4/cpu.c ? ? ? ? ? ? ? ? ? ? ? ?| ? 21 ++-
> ?arch/arm/mach-exynos4/include/mach/entry-macro.S ? | ? 29 +++-
> ?arch/arm/mach-exynos4/include/mach/irqs.h ? ? ? ? ?| ? ?2 +
> ?arch/arm/mach-exynos4/include/mach/map.h ? ? ? ? ? | ? ?1 -
> ?arch/arm/mach-exynos4/include/mach/regs-mct.h ? ? ?| ? ?5 +-
> ?arch/arm/mach-exynos4/mach-origen.c ? ? ? ? ? ? ? ?| ? ?2 +-
> ?.../{mach-smdk4212.c => mach-smdk4x12.c} ? ? ? ? ? | ?128 ++++++++-------
> ?arch/arm/mach-exynos4/mach-smdkv310.c ? ? ? ? ? ? ?| ? ?4 +-
> ?arch/arm/mach-exynos4/mct.c ? ? ? ? ? ? ? ? ? ? ? ?| ?166
> ++++++++++++--------
> ?arch/arm/mach-exynos4/platsmp.c ? ? ? ? ? ? ? ? ? ?| ? ?5 +-
> ?arch/arm/plat-s5p/cpu.c ? ? ? ? ? ? ? ? ? ? ? ? ? ?| ? ?9 +
> ?arch/arm/plat-samsung/include/plat/cpu.h ? ? ? ? ? | ? ?8 +
> ?15 files changed, 251 insertions(+), 150 deletions(-)
> ?rename arch/arm/mach-exynos4/{mach-smdk4212.c => mach-smdk4x12.c} (61%)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
