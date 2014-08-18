From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Mon, 18 Aug 2014 19:34:19 +0545
Subject: [PATCH v4 0/2] Refactor the pm code to use DT based lookup
Message-ID: <1408369761-5458-1-git-send-email-vikas.sajjan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Refactoring the pm.c to avoid using "soc_is_exynos" checks,
instead use the DT based lookup.

While at it, move exynos5250 specific disabling of JPEG USE_RETENTION to pmu.c

changes since v3:
	- Addressed comments from Tomasz Figa.
changes since v2:
	- Addressed Tomasz Figa's comments to unify the functions for exynos4
	and exynos5250.
	- Added new patch to move exynos5250 specific disabling of 
		JPEG USE_RETENTION to pmu.c 
	- Addressed comment from Thomas Abraham.
changes since v1:
	- Address Kukjin Kim comments to respin this patch separately from
		http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/272574.html
	- removed panic, returned if no PMU node found and added check in exynos_wkup_irq.

Rebased on Kukjin Kim's tree, for-next branch 
	https://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/log/?h=for-next

Tested on 5250 based Chromebook.

Vikas Sajjan (2):
  ARM: EXYNOS: Move Disabling of JPEG USE_RETENTION for exynos5250 to
    pmu.c
  ARM: EXYNOS: Refactor the pm code to use DT based lookup

 arch/arm/mach-exynos/pm.c       |  172 ++++++++++++++++++++++++++++-----------
 arch/arm/mach-exynos/pmu.c      |    1 +
 arch/arm/mach-exynos/regs-pmu.h |    1 +
 3 files changed, 127 insertions(+), 47 deletions(-)

-- 
1.7.9.5
