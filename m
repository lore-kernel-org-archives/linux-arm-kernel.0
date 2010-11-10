From: h-kanigeri2@ti.com (Hari Kanigeri)
Date: Wed, 10 Nov 2010 12:00:12 -0600
Subject: [PATCH 0/6] [v2] OMAP: mailbox: enhancements and fixes
Message-ID: <1289412018-18860-1-git-send-email-h-kanigeri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resending correcting the subject format based on Benoit's comment and
fixing the over-indentation pointed out by Sergei.
 
Thanks to Rene Sapiens and Omar Ramirez for their inputs on initial patch
set.
http://www.mail-archive.com/linux-omap at vger.kernel.org/msg37278.html

The patch set addresses the following review comments from Rene and Omar.
http://www.mail-archive.com/linux-omap at vger.kernel.org/msg37626.html
https://patchwork.kernel.org/patch/255091/
https://patchwork.kernel.org/patch/255081/

Following patches are changed because of above review comments:
omap:mailbox-send message in process context
omap:mailbox-add notification support for multiple readers

Following patch is dropped from initial patch set
omap:mailbox-resolve multiple receiver problem

The patch set is tested on omap4 SDP board.

Fernando Guzman Lugo (1):
  OMAP: mailbox: change full flag per mailbox queue instead of global

Hari Kanigeri (5):
  OMAP: mailbox: fix rx interrupt disable in omap4
  OMAP: mailbox: fix checkpatch warnings
  OMAP: mailbox: send message in process context
  OMAP: mailbox: add notification support for multiple readers
  OMAP4: clocks: add dummy clock for mailbox

 arch/arm/mach-omap2/clock44xx_data.c      |    1 +
 arch/arm/mach-omap2/mailbox.c             |    5 +-
 arch/arm/plat-omap/include/plat/mailbox.h |    8 +-
 arch/arm/plat-omap/mailbox.c              |  127 +++++++++++++++++------------
 4 files changed, 83 insertions(+), 58 deletions(-)
