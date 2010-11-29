From: h-kanigeri2@ti.com (Hari Kanigeri)
Date: Mon, 29 Nov 2010 14:24:10 -0600
Subject: [PATCH v5 0/4] OMAP: mailbox: fixes and enhancements
Message-ID: <1291062254-9057-1-git-send-email-h-kanigeri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is the revised set taking into account comments received on previous
patch set
========================

- Dropped the "OMAP: mailbox: fix rx interrupt disable in omap4" patch. This
  patch will be sent along with mailbox hwmod changes.
- Fixed the typo kifo to kfifo in "OMAP: mailbox: send message in process
  context" patch.

References:
http://marc.info/?l=linux-omap&m=129069379825760&w=2
http://marc.info/?l=linux-omap&m=129060518315342&w=2

The previous versions of this patch set can be found here
=======================
http://www.spinics.net/lists/linux-omap/msg40714.html
http://www.spinics.net/lists/arm-kernel/msg104544.html
http://www.spinics.net/lists/linux-omap/msg39988.html
http://www.spinics.net/lists/linux-omap/msg39931.html
http://www.mail-archive.com/linux-omap at vger.kernel.org/msg37278.html

Fernando Guzman Lugo (1):
  OMAP: mailbox: change full flag per mailbox queue instead of global

Hari Kanigeri (3):
  OMAP: mailbox: fix checkpatch warnings
  OMAP: mailbox: send message in process context
  OMAP: mailbox: add notification support for multiple readers

 arch/arm/plat-omap/include/plat/mailbox.h |    8 +-
 arch/arm/plat-omap/mailbox.c              |  130 +++++++++++++++++------------
 2 files changed, 81 insertions(+), 57 deletions(-)
