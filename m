From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Mon, 1 May 2017 22:34:00 +0530
Subject: [GIT PULL] Mailbox changes for v4.12
Message-ID: <CABb+yY0boTgWgUV6uqMzgVO9jPO6NoZVZWwyTK1pHJ7s3NN67A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit ad0376eb1483bd9880770b346f6592aece669e4c:

  Merge tag 'edac_for_4.11_2' of
git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp (2017-03-27
11:09:00 -0700)

are available in the git repository at:

  https://git.linaro.org/landing-teams/working/fujitsu/integration.git
mailbox-for-next

for you to fetch changes up to cb710ab1d8a23f68ff8f45aedf3e552bb90e70de:

  mailbox: handle empty message in tx_tick (2017-04-27 16:20:04 +0530)

----------------------------------------------------------------
- New driver for Broadcom FlexRM controller
- Constify data structures of callback functions in some drivers
- Few bug fixes uncovered by multi-threaded use of mailbox channels
    in blocking mode.

----------------------------------------------------------------
Alexey Klimov (1):
      mailbox: check ->last_tx_done for NULL in case of timer-based polling

Anup Patel (3):
      mailbox: Add driver for Broadcom FlexRM ring manager
      dt-bindings: Add DT bindings info for FlexRM ring manager
      mailbox: Remove depends on COMPILE_TEST for BCM_FLEXRM_MBOX

Bhumika Goyal (1):
      mailbox: constify mbox_chan_ops structures

Steve Lin (2):
      mailbox: bcm-pdc: Add Northstar Plus support to PDC driver
      dt-bindings: mailbox: Update doc with NSP PDC/mailbox support

Sudeep Holla (3):
      mailbox: always wait in mbox_send_message for blocking Tx mode
      mailbox: skip complete wait event if timer expired
      mailbox: handle empty message in tx_tick

 .../bindings/mailbox/brcm,iproc-flexrm-mbox.txt    |   59 +
 .../bindings/mailbox/brcm,iproc-pdc-mbox.txt       |    6 +-
 drivers/mailbox/Kconfig                            |   18 +-
 drivers/mailbox/Makefile                           |    2 +
 drivers/mailbox/bcm-flexrm-mailbox.c               | 1595 ++++++++++++++++++++
 drivers/mailbox/bcm-pdc-mailbox.c                  |   61 +-
 drivers/mailbox/hi6220-mailbox.c                   |    2 +-
 drivers/mailbox/mailbox-xgene-slimpro.c            |    2 +-
 drivers/mailbox/mailbox.c                          |   19 +-
 include/linux/mailbox/brcm-message.h               |   14 +-
 10 files changed, 1746 insertions(+), 32 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/mailbox/brcm,iproc-flexrm-mbox.txt
 create mode 100644 drivers/mailbox/bcm-flexrm-mailbox.c
