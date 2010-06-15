From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 15 Jun 2010 11:27:23 -0700
Subject: [GIT PULL] ARM MSM for 2.6.36
Message-ID: <1276626445-20316-1-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Here are some patch that's have been submitted here a few times for review,
and recently have seen any comments. One fixes a memory defect seen on
our MSM7x30 platform, and the other enabled gpiolib for MSM and trout
specifically.

Anyway, Please pull and let me know if there's any issues.

Daniel

The following changes since commit 7e27d6e778cd87b6f2415515d7127eba53fe5d02:

  Linux 2.6.35-rc3 (2010-06-11 19:14:04 -0700)

are available in the git repository at:
  git://codeaurora.org/quic/kernel/dwalker/linux-msm.git for-russell

Michael Bohan (1):
      arm: mm: Don't free prohibited memmap entries

Pavel Machek (1):
      Add GPIO support for HTC Dream.

 arch/arm/Kconfig                      |    1 +
 arch/arm/mach-msm/Makefile            |    2 +-
 arch/arm/mach-msm/board-trout-gpio.c  |  112 +++++++++++++++++++++++
 arch/arm/mach-msm/board-trout.h       |  157 +++++++++++++++++++++++++++++++++
 arch/arm/mach-msm/include/mach/gpio.h |    7 ++
 arch/arm/mm/init.c                    |   19 ++--
 6 files changed, 287 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/mach-msm/board-trout-gpio.c
