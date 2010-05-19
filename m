From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 19 May 2010 09:33:27 +0100
Subject: Please pull s3c-fb driver updates
Message-ID: <20100519083327.GV26401@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please pull the following patches for the s3c-fb driver for fixes and
device support updates.

The following changes since commit 7ebd467551ed6ae200d7835a84bbda0dcadaa511:
  Linus Torvalds (1):
        Merge branch 'drm-linus' of git://git.kernel.org/.../airlied/drm-2.6

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-2635/s3c-fb

Ben Dooks (5):
      s3c-fb: Change to depending on CONFIG_S3C_FB_DEV
      s3c-fb: only init window colour key controls for windows with blending
      s3c-fb: Initial move to unifying the header files
      s3c-fb: udpate to support s3c2416/s3c2443 style hardware
      s3c-fb: Integrate palette setup code into main driver

InKi Dae (2):
      s3c-fb: add default window feature.
      s3c-fb: fixed distortedness situation for the mode more then 24bpp.

 arch/arm/mach-s3c64xx/include/mach/regs-fb.h    |   20 --
 arch/arm/mach-s5pc100/include/mach/regs-fb.h    |   34 --
 arch/arm/plat-samsung/include/plat/fb.h         |    3 +
 arch/arm/plat-samsung/include/plat/regs-fb-v4.h |   78 +-----
 arch/arm/plat-samsung/include/plat/regs-fb.h    |    5 +
 drivers/video/Kconfig                           |    2 +-
 drivers/video/s3c-fb.c                          |  412 +++++++++++++++++++----
 7 files changed, 362 insertions(+), 192 deletions(-)
