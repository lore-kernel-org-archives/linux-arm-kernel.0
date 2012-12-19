From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 19 Dec 2012 10:27:26 -0800
Subject: [GIT PULL 2/2] Samsung fixes-audio part for v3.8-rc1
Message-ID: <008501cdde16$8081a800$8184f800$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof

This is for fix the following build error in dev-audio.c on current Samsung
platforms :-(

arch/arm/mach-exynos/dev-audio.c:58:4: error: unknown field 'src_clk'
specified in initializer
arch/arm/mach-exynos/dev-audio.c:58:4: warning: initialization makes integer
from pointer without a cast [enabled by default]
arch/arm/mach-exynos/dev-audio.c:58:4: warning: (near initialization for
'i2sv5_pdata.type.i2s.idma_addr') [enabled by default]
arch/arm/mach-exynos/dev-audio.c:91:4: error: unknown field 'src_clk'
specified in initializer
arch/arm/mach-exynos/dev-audio.c:91:4: warning: initialization makes integer
from pointer without a cast [enabled by default]
arch/arm/mach-exynos/dev-audio.c:91:4: warning: (near initialization for
'i2sv3_pdata.type.i2s.idma_addr') [enabled by default]

Actually, Pdma's patches were in my tree before release v3.7 but I was
holding on because I needed to check about regarding audio driver part.
Anyway, this is required to fix the problem.

If any problems, please kindly let me know.

Thanks.

Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 74779e22261172ea728b989310f6ecc991b57d62:

  Merge tag 'for-3.8-rc1' of git://gitorious.org/linux-pwm/linux-pwm
(2012-12-19 08:19:07 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
v3.8-samsung-fixes-audio

for you to fetch changes up to fb0a20594787f8a1f10389eec46a2cd51fa6a533:

  ARM: EXYNOS: Avoid passing the clks through platform data (2012-12-19
09:49:29 -0800)

----------------------------------------------------------------
Padmavathi Venna (5):
      ARM: S3C64XX: Add I2S clkdev support
      ARM: S5PC100: Add I2S clkdev support
      ARM: S5P64X0: Add I2S clkdev support
      ARM: S5PV210: Avoid passing the clks through platform data
      ARM: EXYNOS: Avoid passing the clks through platform data

 arch/arm/mach-exynos/dev-audio.c      |   12 --------
 arch/arm/mach-s3c64xx/clock.c         |  126
++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------
------
 arch/arm/mach-s3c64xx/dev-audio.c     |   11 --------
 arch/arm/mach-s5p64x0/clock-s5p6440.c |   49
+++++++++++++++++++++-----------
 arch/arm/mach-s5p64x0/clock-s5p6450.c |   61
+++++++++++++++++++++++++++-------------
 arch/arm/mach-s5p64x0/dev-audio.c     |   12 --------
 arch/arm/mach-s5pc100/clock.c         |   48
+++++++++++++++++++------------
 arch/arm/mach-s5pc100/dev-audio.c     |   16 -----------
 arch/arm/mach-s5pv210/dev-audio.c     |   16 -----------
 9 files changed, 182 insertions(+), 169 deletions(-)
