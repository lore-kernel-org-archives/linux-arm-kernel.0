From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 6 Sep 2017 23:34:16 +0530
Subject: [GIT PULL] Mailbox changes for v4.14
Message-ID: <CABb+yY3YPPG2+h6ed=Sabqqgc45QXyxT=Y56-+HK6Khq+Lyw6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 14ccee78fc82f5512908f4424f541549a5705b89:

  Linux 4.13-rc6 (2017-08-20 14:13:52 -0700)

are available in the git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v4.14

for you to fetch changes up to 1da92afbbfcde9dcbbf85cc94ef506c986c7e4a1:

  mailbox: bcm-flexrm-mailbox: Use txdone_ack instead of txdone_poll
(2017-08-31 08:39:04 +0530)

----------------------------------------------------------------
Just behavorial changes to a controller driver:

- Modified the Broadcom's Flexrm mailbox driver to
  support debugfs and TX-Done mechanism by ACK.
  Nothing for the core mailbox stack.

----------------------------------------------------------------
Anup Patel (5):
      mailbox: bcm-flexrm-mailbox: Set IRQ affinity hint for FlexRM ring IRQs
      mailbox: bcm-flexrm-mailbox: Add debugfs support
      mailbox: bcm-flexrm-mailbox: Fix mask used in CMPL_START_ADDR_VALUE()
      mailbox: bcm-flexrm-mailbox: Use bitmap instead of IDA
      mailbox: bcm-flexrm-mailbox: Use txdone_ack instead of txdone_poll

 drivers/mailbox/bcm-flexrm-mailbox.c | 252 ++++++++++++++++++++++++-----------
 1 file changed, 175 insertions(+), 77 deletions(-)
