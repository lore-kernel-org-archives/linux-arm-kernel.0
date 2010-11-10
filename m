From: linux@dominikbrodowski.net (Dominik Brodowski)
Date: Wed, 10 Nov 2010 14:36:57 +0100
Subject: [RFC] PCMCIA bugfixes
Message-ID: <20101110133657.GA22986@comet.dominikbrodowski.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey,

in order to address a few -- mostly minor -- issues, I intend to push these
changes shortly. They're available at

git://git.kernel.org/pub/scm/linux/kernel/git/brodo/pcmcia-2.6.git urgent

As usual, I'm interested in your input to this patch series. The individual
patches will be sent out (at least) to the PCMCIA list in a few moments.

Best,
        Dominik

Andres Salomon (1):
      pcmcia: fix warning in synclink driver

Joe Perches (1):
      drivers/pcmcia/soc_common.c: Use printf extension %pV

Komuro (1):
      pd6729: Coding Style fixes

Nicolas Kaiser (1):
      pcmcia/cm4000: fix error code

Uwe Kleine-K?nig (1):
      pcmcia/sa1100: don't put machine specific init functions in .init.text

 drivers/char/pcmcia/cm4000_cs.c   |    3 ++-
 drivers/char/pcmcia/synclink_cs.c |    1 +
 drivers/pcmcia/pd6729.c           |    8 ++++----
 drivers/pcmcia/pd6729.h           |    2 +-
 drivers/pcmcia/pxa2xx_sharpsl.c   |    2 +-
 drivers/pcmcia/sa1100_assabet.c   |    2 +-
 drivers/pcmcia/sa1100_cerf.c      |    2 +-
 drivers/pcmcia/sa1100_generic.c   |    2 +-
 drivers/pcmcia/sa1100_h3600.c     |    2 +-
 drivers/pcmcia/sa1100_shannon.c   |    2 +-
 drivers/pcmcia/sa1100_simpad.c    |    2 +-
 drivers/pcmcia/soc_common.c       |    9 +++++++--
 12 files changed, 22 insertions(+), 15 deletions(-)
