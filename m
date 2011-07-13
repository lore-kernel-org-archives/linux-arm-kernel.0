From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Wed, 13 Jul 2011 15:54:55 +0100
Subject: [PATCH 0/3] pxa2xx related pcmcia tidyups.
Message-ID: <1310568898-9201-1-git-send-email-jic23@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Big one here is that 10 drivers don't do anything for socket_init and
socket_suspend.  That would suggest making them optional?

The other patch is a trivial cleanup of the one device I actually have.

Thanks,

Jonathan

Jonathan Cameron (3):
  drivers:pcmcia:soc_common:  make socket_init and socket_suspend
    optional
  pcmcia: pxa2xx: remove empty socket_init / socket_resume functions.
  pxa2xx pcmcia - stargate 2 use gpio array.

 drivers/pcmcia/pxa2xx_balloon3.c  |   10 ----------
 drivers/pcmcia/pxa2xx_cm_x255.c   |   11 -----------
 drivers/pcmcia/pxa2xx_cm_x270.c   |   11 -----------
 drivers/pcmcia/pxa2xx_colibri.c   |   11 -----------
 drivers/pcmcia/pxa2xx_mainstone.c |   10 ----------
 drivers/pcmcia/pxa2xx_palmld.c    |   11 -----------
 drivers/pcmcia/pxa2xx_palmtc.c    |   11 -----------
 drivers/pcmcia/pxa2xx_palmtx.c    |   11 -----------
 drivers/pcmcia/pxa2xx_stargate2.c |   34 +++++++++++-----------------------
 drivers/pcmcia/pxa2xx_viper.c     |   10 ----------
 drivers/pcmcia/soc_common.c       |    7 ++++---
 11 files changed, 15 insertions(+), 122 deletions(-)

-- 
1.7.3.4
