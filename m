From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Mon, 1 Aug 2016 08:40:57 +0530
Subject: [GIT PULL] Mailbox changes for v4.8
Message-ID: <CABb+yY2MFEPTc_Xi+3sT4pqP3ECXSJ6Tby3BRz-jmFQAPLYxUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 8714f8f5fe396ca513ccaaac2304497439c181fb:

  Merge branch 'for-linus' of git://git.kernel.dk/linux-block
(2016-06-11 18:42:59 -0700)

are available in the git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
mailbox-for-next

for you to fetch changes up to a68b216676e89fa959a23b583b56f9ce7df81b37:

  mailbox: Fix format and type mismatches in Broadcom PDC driver
(2016-07-28 21:27:31 +0530)

----------------------------------------------------------------
- Broadcom
       New PDC controller driver and bindings
- Misc
     PL320 - Convert from 'raw' IO to 'relaxed' version
     Test - fix dangling pointer

----------------------------------------------------------------
Ben Dooks (1):
      mailbox: pl320: remove __raw IO

Rob Rice (3):
      dt-bindings: add bindings documentation for PDC driver.
      mailbox: Add Broadcom PDC mailbox driver
      mailbox: Fix format and type mismatches in Broadcom PDC driver

Sudeep Holla (1):
      mailbox: mailbox-test: set tdev->signal to NULL after freeing

 .../bindings/mailbox/brcm,iproc-pdc-mbox.txt       |   23 +
 drivers/mailbox/Kconfig                            |    9 +
 drivers/mailbox/Makefile                           |    2 +
 drivers/mailbox/bcm-pdc-mailbox.c                  | 1531 ++++++++++++++++++++
 drivers/mailbox/mailbox-test.c                     |    1 +
 drivers/mailbox/pl320-ipc.c                        |   46 +-
 include/linux/mailbox/brcm-message.h               |   56 +
 7 files changed, 1645 insertions(+), 23 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/mailbox/brcm,iproc-pdc-mbox.txt
 create mode 100644 drivers/mailbox/bcm-pdc-mailbox.c
 create mode 100644 include/linux/mailbox/brcm-message.h
