From: davidb@codeaurora.org (David Brown)
Date: Thu, 13 Sep 2012 11:56:33 -0700
Subject: [GIT PULL 2/5] msm non-critical fixes
In-Reply-To: <20120913185342.GA29823@codeaurora.org>
References: <20120913185342.GA29823@codeaurora.org>
Message-ID: <20120913185633.GB30032@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 28a33cbc24e4256c143dce96c7d93bf423229f92:

  Linux 3.5 (2012-07-21 13:58:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davidb/linux-msm.git tags/msm-fix-noncrit-for-3.7

for you to fetch changes up to 10717e04d3502cf4a8aa6408d59093e2bbb4645b:

  ARM: msm: Fix early debug uart mapping on some memory configs (2012-09-13 10:48:35 -0700)

----------------------------------------------------------------
Some non-critical fixes for msm platforms.  The missing FPGA init call
fix is necessary to compile the 8660 target.  The iomapping calls are
needed to prevent duplicate mappings with differing attributes.  And,
the debug UART change keeps the debug UART working on targets with
more than 512MB of memory.

----------------------------------------------------------------
David Brown (1):
      ARM: msm: Remove call to missing FPGA init on 8660

Rohit Vaswani (2):
      ARM: msm: io: Remove 7x30 iomap region from 7x00
      ARM: msm: io: Change the default static iomappings to be shared

Stephen Boyd (1):
      ARM: msm: Fix early debug uart mapping on some memory configs

 arch/arm/mach-msm/board-msm8x60.c               |  5 -----
 arch/arm/mach-msm/include/mach/msm_iomap-8960.h |  2 +-
 arch/arm/mach-msm/include/mach/msm_iomap-8x60.h |  2 +-
 arch/arm/mach-msm/io.c                          | 25 +++++++++++++------------
 4 files changed, 15 insertions(+), 19 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
