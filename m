From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Sat, 22 May 2010 20:14:11 +0300
Subject: [PATCH v3 00/14] omap: mailbox: bunch of cleanups
Message-ID: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These are hopefully non-functional changes. Just shuffling code around, and
removing unecessary stuff.

In v2 I tried to split platform_device and also make mailbox_mach built-in. Not
any more.

Comments from Felipe Balbi, Tony Lindgren, Hiroshi DOYU, and Russell King.

Felipe Contreras (14):
  omap: mailbox: trivial whitespace cleanups
  omap: mailbox: trivial cleanups
  omap: mailbox: reorganize structures
  omap: mailbox: 2420 should be detected at run-time
  omap: mailbox: use correct config for omap1
  omap: mailbox: update omap1 probing
  omap: mailbox: don't export unecessary symbols
  omap: mailbox: remove unecessary fields
  omap: mailbox: add IRQ names
  omap: mailbox: reorganize registering
  omap: mailbox: only compile for configured archs
  omap: mailbox: standarize on 'omap-mailbox'
  omap: mailbox: simplify omap_mbox_register()
  omap: mailbox: reorganize headers

 arch/arm/mach-omap1/devices.c             |   11 +-
 arch/arm/mach-omap1/mailbox.c             |   52 ++++-----
 arch/arm/mach-omap2/devices.c             |    6 +-
 arch/arm/mach-omap2/mailbox.c             |  177 +++++++++++++----------------
 arch/arm/plat-omap/include/plat/mailbox.h |   16 +--
 arch/arm/plat-omap/mailbox.c              |  136 +++++++++-------------
 6 files changed, 168 insertions(+), 230 deletions(-)
