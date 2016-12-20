From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 20 Dec 2016 19:44:48 +0530
Subject: [GIT PULL] Mailbox changes for v4.10
Message-ID: <CABb+yY34U2Otupw5SUJLYccTTF5iNA=Lgy3DxYxHW3D6fVkG-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 16ae16c6e5616c084168740990fc508bda6655d4:

  Merge tag 'mmc-v4.9-rc5' of
git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc (2016-11-24
10:51:18 -0800)

are available in the git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
mailbox-for-next

for you to fetch changes up to db4d22c07e3e652eeec82abcc1399e6305edd838:

  mailbox: mailbox-test: allow reserved areas in SRAM (2016-12-19
20:10:23 +0530)

----------------------------------------------------------------
- New features (poll and SRAM usage) added to the mailbox-test driver
- Major update of Broadcom's PDC controller driver
- Minor fix for auto-loading test and STI driver modules

----------------------------------------------------------------
Javier Martinez Canillas (2):
      mailbox: mailbox-test: Fix module autoload
      mailbox: sti: Fix module autoload for OF registration

Rob Rice (9):
      mailbox: bcm-pdc: Use octal permissions rather than symbolic
      mailbox: bcm-pdc: Convert from interrupts to poll for tx done
      mailbox: bcm-pdc: streamline rx code
      mailbox: bcm-pdc: Try to improve branch prediction
      mailbox: bcm-pdc: Convert from threaded IRQ to tasklet
      mailbox: bcm-pdc: Don't use iowrite32 to write DMA descriptors
      mailbox: bcm-pdc: Performance improvements
      mailbox: bcm-pdc: Simplify interrupt handler logic
      mailbox: bcm-pdc: Remove unnecessary void* casts

Steve Lin (2):
      mailbox: bcm-pdc: Changes so mbox client can be removed / re-inserted
      mailbox: bcm-pdc: PDC driver leaves debugfs files after removal

Sudeep Holla (2):
      mailbox: mailbox-test: add support for fasync/poll
      mailbox: mailbox-test: allow reserved areas in SRAM

 drivers/mailbox/bcm-pdc-mailbox.c | 548 ++++++++++++++++++++++----------------
 drivers/mailbox/mailbox-sti.c     |   1 +
 drivers/mailbox/mailbox-test.c    |  92 ++++++-
 3 files changed, 407 insertions(+), 234 deletions(-)
