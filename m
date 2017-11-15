From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 15 Nov 2017 21:06:50 +0530
Subject: [GIT PULL] Mailbox changes for v4.15
Message-ID: <CABb+yY2-7WRaOqTHibFnb2JdQ96ki6KX22K61=XW4YV+nE1iPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 15f859ae5c43c7f0a064ed92d33f7a5bc5de6de0:

  Merge tag 'for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/dledford/rdma
(2017-10-26 23:04:14 +0200)

are available in the git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v4.15

for you to fetch changes up to 1f90a2162fb3cdfd9c44380bf16209af00f7acbe:

  mailbox/omap: unregister mbox class (2017-11-14 20:21:35 +0530)

----------------------------------------------------------------
Change to POLL api and fixes for FlexRM and OMAP driver

- Core: Prefer ACK method over POLL, if both supported
- Test: use flag instead of special character
- FlexRM: Usual driver internal minor churn
- Omap: fix error path

----------------------------------------------------------------
Anup Patel (4):
      mailbox: bcm-flexrm-mailbox: Fix FlexRM ring flush sequence
      mailbox: bcm-flexrm-mailbox: Print ring number in errors and warnings
      mailbox: bcm-flexrm-mailbox: Use common GPL comment header
      mailbox: Build Broadcom FlexRM driver as loadable module for iProc SOCs

Arvind Yadav (1):
      mailbox/omap: unregister mbox class

Scott Branden (1):
      mailbox: bcm-flexrm-mailbox: add depends on ARCH_BCM_IPROC

Sudeep Holla (2):
      mailbox: reset txdone_method TXDONE_BY_POLL if client knows_txdone
      mailbox: mailbox-test: don't rely on rx_buffer content to signal
data ready

 drivers/mailbox/Kconfig              |  3 +-
 drivers/mailbox/bcm-flexrm-mailbox.c | 66 ++++++++++++++++++++++++++----------
 drivers/mailbox/mailbox-test.c       | 11 +++---
 drivers/mailbox/mailbox.c            |  4 +--
 drivers/mailbox/omap-mailbox.c       |  6 +++-
 drivers/mailbox/pcc.c                |  4 +--
 6 files changed, 66 insertions(+), 28 deletions(-)
