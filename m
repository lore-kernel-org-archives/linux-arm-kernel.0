From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 12 Feb 2013 13:10:19 +0100
Subject: [GIT PULL] <mach/id.h> fixup of fallouts
Message-ID: <CACRpkdYHS+2d7h76CdmX-Ah+_fzOhjLheT_5vNxUWxLd-K0Kww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC guys,

this is a pull request for fixing the fallout from the <mach/id.h> removal.

I've pulled it into your next/cleanup branch as a test, and it magically
works.

Rafael still has not ACKed the first oneliner, I don't think he'd mind, and
I have an ACK from Sam on the MFD portions.

Please pull this in (unless you applied the individual patches instead).

After this the ux500 compiles and boots just fine.

Yours,
Linus Walleij


The following changes since commit 7a4f26097d389c16c9956bc03b81532698d97d64:

  ARM: ux500: de-globalize <mach/id.h> (2013-01-29 18:47:37 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/for-arm-soc-cleanup

for you to fetch changes up to 05ec260edecaf3dc214cff49d43b1ad9b2cbb710:

  mfd: db8500-prcmu: update resource passing (2013-02-12 12:44:27 +0100)

----------------------------------------------------------------
Two fixes for broken <mach/id.h> cleanup.

----------------------------------------------------------------
Linus Walleij (2):
      drivers/db8500-cpufreq: delete dangling include
      mfd: db8500-prcmu: update resource passing

 arch/arm/mach-ux500/board-mop500.c   |   5 +-
 arch/arm/mach-ux500/cpu-db8500.c     |   7 +-
 arch/arm/mach-ux500/devices-db8500.c |  44 +++++++++++++
 arch/arm/mach-ux500/devices-db8500.h |   5 ++
 drivers/cpufreq/db8500-cpufreq.c     |   1 -
 drivers/mfd/db8500-prcmu.c           | 122 +++++++++++++++++++++++------------
 include/linux/mfd/db8500-prcmu.h     |  14 ----
 include/linux/mfd/dbx500-prcmu.h     |  46 +++++++++++++
 8 files changed, 180 insertions(+), 64 deletions(-)
