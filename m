From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 11 May 2015 12:11:34 +0900
Subject: [GIT PULL] ARM: EXYNOS: Fixes for 4.1, second try
Message-ID: <1431313894-16934-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Kukjin,

This groups important fix for current RC cycle. The patch was present
on mailing list for quite long. It was tested. 

I responded to all your questions without any follow ups from your side.
The only issue left - replacing soc_is_exynos() with
of_machine_is_compatible() is done in separate patch because the fix
should not contain unrelated changes.

Best regards,
Krzysztof


The following changes since commit 77b0ffdc4bbd267e9589aa025047e512322fc643:

  Merge branch 'v4.2-next/dt-samsung' into for-next (2015-05-09 04:03:46 +0900)

are available in the git repository at:


  https://github.com/krzk/linux.git tags/samsung-fixes-4.1-2

for you to fetch changes up to b82f3a05ff0b5eaf2c9900eeb34e58a6624db8d9:

  ARM: EXYNOS: Fix failed second suspend on Exynos4 (2015-05-11 11:03:09 +0900)

----------------------------------------------------------------
Fixes failed second suspend to RAM on Exynos4412 based Trats2 board. This has
shown up after enabling L2 cache but actually the "use delayed reset assertion"
feature is to be blamed.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      ARM: EXYNOS: Fix failed second suspend on Exynos4

 arch/arm/mach-exynos/common.h  |  2 ++
 arch/arm/mach-exynos/exynos.c  | 27 +++++++++++++++++++++++++++
 arch/arm/mach-exynos/platsmp.c | 39 ++-------------------------------------
 arch/arm/mach-exynos/suspend.c |  3 +++
 4 files changed, 34 insertions(+), 37 deletions(-)
