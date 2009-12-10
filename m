From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 10 Dec 2009 11:18:35 -0800
Subject: [GIT PULL] msm updates for v2.6.33
Message-ID: <1260472715.11877.103.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Please pull these updates for the arm MSM sub-architecture. The biggest
change here is support for the HTC Dream/Google G1 phone, and a few
small Kconfig/compile fixes. There is also the addition of a maintainer
entry that covers this sub-architecture and it's drivers which are
currently unmaintained.

Daniel

--
The following changes since commit 333a07437c31ea8c16a2b82071629a540ae1e50f:
  Linus Torvalds (1):
        Merge branch 'release' of git://git.kernel.org/.../aegl/linux-2.6

are available in the git repository at:

  git://codeaurora.org/quic/kernel/dwalker/linux-msm.git for-linus

Daniel Walker (1):
      Add arm msm maintainer entry

Pavel Machek (5):
      msm: make debugging UART (for DEBUG_LL) configurable
      msm: add minimal board file for HTC Dream device
      msm: Add memory map for HTC Dream
      video: Allow selecting MSM framebuffer in Kconfig
      HTC Dream: mmc compilation fixes

 MAINTAINERS                                  |   13 ++++
 arch/arm/mach-msm/Kconfig                    |   30 ++++++++
 arch/arm/mach-msm/Makefile                   |    1 +
 arch/arm/mach-msm/board-dream.c              |   93 ++++++++++++++++++++++++++
 arch/arm/mach-msm/board-dream.h              |    5 ++
 arch/arm/mach-msm/include/mach/debug-macro.S |   24 +++++--
 arch/arm/mach-msm/include/mach/mmc.h         |   26 +++++++
 arch/arm/mach-msm/include/mach/msm_iomap.h   |   12 +++
 arch/arm/mach-msm/include/mach/uncompress.h  |    7 ++
 arch/arm/mach-msm/io.c                       |    3 +
 drivers/mmc/host/msm_sdcc.c                  |    5 +-
 drivers/video/Kconfig                        |    2 +-
 12 files changed, 209 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/mach-msm/board-dream.c
 create mode 100644 arch/arm/mach-msm/board-dream.h
 create mode 100644 arch/arm/mach-msm/include/mach/mmc.h
