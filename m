From: h-kanigeri2@ti.com (Hari Kanigeri)
Date: Tue, 23 Nov 2010 15:26:52 -0600
Subject: [PATCH v4 0/5] OMAP: mailbox: fixes and enhancements
Message-ID: <1290547617-16640-1-git-send-email-h-kanigeri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks to Benoit and Felipe Balbi for their comments.

Here is the revised set taking into account comments received.
========================

- Added more description for checkpatch warnings
- Created revision field to check for mailbox IP version to use for rx
  interrupt disable functionality.
- Cleaned up description in change full flag per mailbox patch.

References:
http://marc.info/?l=linux-omap&m=129012283514652&w=2
http://marc.info/?l=linux-omap&m=129016767426046&w=2
http://www.mail-archive.com/linux-omap at vger.kernel.org/msg38826.html

The previous versions of this patch set can be found here
=======================

http://www.spinics.net/lists/arm-kernel/msg104544.html
http://www.spinics.net/lists/linux-omap/msg39988.html
http://www.spinics.net/lists/linux-omap/msg39931.html
http://www.mail-archive.com/linux-omap at vger.kernel.org/msg37278.html

Fernando Guzman Lugo (1):
  OMAP: mailbox: change full flag per mailbox queue instead of global

Hari Kanigeri (4):
  OMAP: mailbox: fix rx interrupt disable in omap4
  OMAP: mailbox: fix checkpatch warnings
  OMAP: mailbox: send message in process context
  OMAP: mailbox: add notification support for multiple readers

 arch/arm/mach-omap2/mailbox.c             |    7 ++-
 arch/arm/plat-omap/include/plat/mailbox.h |   12 ++-
 arch/arm/plat-omap/mailbox.c              |  135 +++++++++++++++++------------
 3 files changed, 96 insertions(+), 58 deletions(-)
