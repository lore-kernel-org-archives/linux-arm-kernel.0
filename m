From: h-kanigeri2@ti.com (Hari Kanigeri)
Date: Thu, 18 Nov 2010 13:15:37 -0600
Subject: [PATCH v3 0/5] OMAP: mailbox: enhancements and fixes
Message-ID: <1290107742-16760-1-git-send-email-h-kanigeri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sending the patch set by seperating the clock related patch seperated
out based on Paul Walmsey's comment.
http://www.spinics.net/lists/arm-kernel/msg103692.html
The clock patch will be sent out as a seperate patch.

The previous versions of this patch set can be found here
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

 arch/arm/mach-omap2/mailbox.c             |    5 +-
 arch/arm/plat-omap/include/plat/mailbox.h |    8 +-
 arch/arm/plat-omap/mailbox.c              |  127 +++++++++++++++++------------
 3 files changed, 82 insertions(+), 58 deletions(-)
