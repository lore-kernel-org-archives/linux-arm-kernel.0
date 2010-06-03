From: Hiroshi.DOYU@nokia.com (Hiroshi DOYU)
Date: Thu,  3 Jun 2010 09:34:08 +0300
Subject: [PATCH 00/10] omap mailbox: Paches for -next
Message-ID: <1275546858-29507-1-git-send-email-Hiroshi.DOYU@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The following patches are for -next for omap mailbox module.

Fernando Guzman Lugo (4):
  Mailbox: free mailbox interrupt before freeing blk queue
  Mailbox: flush pending deferred works before freeing blk queue
  Mailbox: Check valid registered callback before calling
  Mailbox: disable mailbox interrupt when request queue

Hiroshi DOYU (2):
  Mailbox: new mutext lock for h/w mailbox configuration
  omap mailbox: Set a device in logical mbox instance for traceability

Ohad Ben-Cohen (4):
  omap: mailbox: convert rwlocks to spinlock
  omap: mailbox cleanup: split MODULE_AUTHOR line
  omap: mailbox: remove (un)likely macros from cold paths
  omap: mailbox: convert block api to kfifo

 arch/arm/mach-omap2/mailbox.c             |    3 +-
 arch/arm/plat-omap/Kconfig                |    9 ++
 arch/arm/plat-omap/include/plat/mailbox.h |    4 +-
 arch/arm/plat-omap/mailbox.c              |  182 ++++++++++++++++-------------
 4 files changed, 111 insertions(+), 87 deletions(-)
