From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sun, 17 Nov 2013 02:07:25 +0400
Subject: [PATCH v2 0/5]
Message-ID: <1384639650-3919-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please apply the following patches that fix the sa1100 framebuffer and PCMCIA
timings calculation if CPU frequency driver is not available.

Changes since V1:
* Corrected patch adding sa1111 pcmcia device - offset was wrong.

----------------------------------------------------------------
Dmitry Eremin-Solenikov (5):
      arm: sa1100: add cpu clock
      fbdev: sa1100fb: make use of device clock
      pcmcia: sa1100: make use of device clock
      arm: sa1100: add a clock alias for sa1111 pcmcia device
      pcmcia: sa1111: make use of device clock

 arch/arm/mach-sa1100/clock.c    | 36 ++++++++++++++++++++++++++++++++++++
 drivers/pcmcia/sa1100_generic.c |  1 +
 drivers/pcmcia/sa1111_generic.c |  4 ++++
 drivers/pcmcia/sa11xx_base.c    | 14 ++++++++++++--
 drivers/video/sa1100fb.c        | 24 +++++++++++++++++-------
 drivers/video/sa1100fb.h        |  1 +
 6 files changed, 71 insertions(+), 9 deletions(-)
