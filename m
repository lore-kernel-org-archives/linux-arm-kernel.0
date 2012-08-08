From: prabhakar.lad@ti.com (Prabhakar Lad)
Date: Wed, 8 Aug 2012 18:00:18 +0530
Subject: [PATCH 0/2] Replace the obsolete preset API by timings API
Message-ID: <1344429020-27616-1-git-send-email-prabhakar.lad@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This first patch replaces the obsolete preset API by timings
API for davinci VPBE, appropriate chnages in machine file for
dm644x in which VPBE is enabled. And the second patch adds support for 
timings API for ths7303 driver. Sending them as s series 
since VPBE uses the ths7303 driver.

Hans Verkuil (1):
  dm644x: replace the obsolete preset API by the timings API.

Manjunath Hadli (1):
  ths7303: enable THS7303 for HD modes

 arch/arm/mach-davinci/board-dm644x-evm.c   |   15 ++--
 arch/arm/mach-davinci/dm644x.c             |   17 +---
 drivers/media/video/davinci/vpbe.c         |  110 ++++++++++++----------------
 drivers/media/video/davinci/vpbe_display.c |   60 +++++++--------
 drivers/media/video/davinci/vpbe_venc.c    |   25 +++---
 drivers/media/video/ths7303.c              |  107 +++++++++++++++++++++++----
 include/media/davinci/vpbe.h               |   14 ++--
 include/media/davinci/vpbe_types.h         |    8 +--
 include/media/davinci/vpbe_venc.h          |    2 +-
 9 files changed, 202 insertions(+), 156 deletions(-)
