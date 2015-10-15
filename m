From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Oct 2015 15:08:43 +0200
Subject: [PATCH 00/10] ARM MTD AFS v2 partition support
Message-ID: <1444914533-27782-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Years ago, the ARM reference platforms moved away from the footer
format parsed by the current AFS code in MTD. As far as I can
tell this begun with the RealView reference designs (mach-realview)
and the new format has been used in RealView, Versatile Express
and recently the Juno Development platform (64bit).

The code has not been working for newer designs for a long time.
Proper parsing of the flash image partitions is very helpful when
you want to replace firmware when running full Linux and none of
the boot monitors or boot loaders.

After this, AFS parsing will work on all ARM reference designs,
or well, all I could test. I tested the Integrator/AP, RealView
PB11MPCore and Juno Development Platform.

The first 9 patches basically refactors the current code to
make the old partition format more encapsulated, while the last
patch adds the new v2 format.

Linus Walleij (10):
  mtd: afs: rename structs and functions for v1
  mtd: enable AFS selection for ARM64
  mtd: afs: break out v1 footer magic to a define
  mtd: afs: refactor v1 partition parsing
  mtd: afs: simplify partition parsing
  mtd: afs: simplify partition detection
  mtd: factor out v1 partition parsing
  mtd: afs: factor footer parsing into the v1 part parsing
  mtd: afs: factor the IIS read into partition parser
  mtd: afs: add v2 partition parsing

 drivers/mtd/Kconfig |   2 +-
 drivers/mtd/afs.c   | 388 +++++++++++++++++++++++++++++++++++-----------------
 2 files changed, 263 insertions(+), 127 deletions(-)

-- 
2.4.3
