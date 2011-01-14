From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 14 Jan 2011 11:08:59 -0600
Subject: [GIT PULL v3] pxa: patches for v2.6.38-rc
Message-ID: <AANLkTi=B3sfBXS3vN1+nnRa5m64jiaqmzRFfi6w07dJB@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

I rebased the branch on top of devel-stable. The conflict in irq.c is
fixed. And there is a one-liner patch fixing a building issue in spitz.c
missing of physmap.h. Please re-pull and let know any other issue.

Sorry for the inconvenience.

The following changes since commit 5b88128fd70dcf0d5d7c0ae7d7849777ff925bde:

  ARM: plat-stmp3xxx: irq_data conversion. (2011-01-13 17:19:14 +0100)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git devel

Eric Miao (2):
      ARM: pxa: fix recursive calls in pxa_low_gpio_chip
      ARM: pxa: fix building issue of missing physmap.h

Marek Vasut (4):
      ARM: pxa: fix warning in zeus.c
      ARM: pxa: remove unused variable in clock-pxa3xx.c
      ARM: pxa: use cpu_has_ipr() consistently in irq.c
      ARM: pxa: fix suspend/resume array index miscalculation

Pavel Machek (1):
      ARM: sa1111: fix typo in sa1111_retrigger_lowirq()

Philip Rakity (2):
      ARM: mmp: MMP2 drive strength FAST using wrong value
      ARM: mmp: PXA910 drive strength FAST using wrong value

 arch/arm/common/sa1111.c                    |    2 +-
 arch/arm/mach-mmp/include/mach/mfp-mmp2.h   |    2 +-
 arch/arm/mach-mmp/include/mach/mfp-pxa910.h |    2 +-
 arch/arm/mach-pxa/clock-pxa3xx.c            |    1 -
 arch/arm/mach-pxa/irq.c                     |   53 ++++++++++-----------------
 arch/arm/mach-pxa/spitz.c                   |    1 +
 arch/arm/mach-pxa/zeus.c                    |    4 +-
 7 files changed, 26 insertions(+), 39 deletions(-)
