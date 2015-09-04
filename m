From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 4 Sep 2015 12:06:22 -0700
Subject: [GIT PULL] Mailbox changes for v4.3
Message-ID: <CABb+yY2b0heDoqGoBCbaE4zdWCTwTNM-A3r7LriKo5g2C+OKVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 4e6b6ee253ce58aa156d7f1448d1038679b26783:

  Merge tag 'md/4.2-rc5-fixes' of git://neil.brown.name/md (2015-08-05
11:02:42 +0200)

are available in the git repository at:


  http://git.linaro.org/landing-teams/working/fujitsu/integration.git
mailbox-for-next

for you to fetch changes up to 86e488adaab77a733b01e759bf7bfda054479660:

  mailbox: arm_mhu: reduce txpoll_period from 10ms to 1 ms (2015-08-10
14:29:44 +0530)

----------------------------------------------------------------

Mainly we move from jiffy based timer to HRTIMER for finer control over
polling. Then a controller reduces its polling period from 10 to 1ms.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      mailbox: Drop owner assignment from platform_driver

Sudeep Holla (2):
      mailbox: switch to hrtimer for tx_complete polling
      mailbox: arm_mhu: reduce txpoll_period from 10ms to 1 ms

 drivers/mailbox/arm_mhu.c          |  2 +-
 drivers/mailbox/bcm2835-mailbox.c  |  1 -
 drivers/mailbox/mailbox.c          | 27 +++++++++++++++------------
 include/linux/mailbox_controller.h |  7 ++++---
 4 files changed, 20 insertions(+), 17 deletions(-)
