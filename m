From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Thu, 12 Jan 2012 16:09:23 +0100
Subject: [PATCH 0/5] S3C24XX: unclutter clock init, mostly for S3C2443
Message-ID: <201201121609.24110.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series tries to unclutter the clock init of S3C2443 and onward a bit.
Most clock-information can be read via generic code and doesn't need
special code for reading the raste of the h and p clock.

I'm not 100% sure on the sanity of the fifth patch, which removes the
plat-s3c24xx/clock.c, as it duplicates a little bit of code into the
s3c2412 machine directory but would remove another nearly meaningless
file from plat-s3c24xx.

This series applies cleanly against current linux-next.

Heiko Stuebner (5):
  S3C2443/S3C2416: remove XXX_setup_clocks methods
  S3C2443/S3C2416: add get_rate for clk_h
  S3C2443/S3C2416: add get_rate for clk_p
  S3C2443/S3C2416: remove call to s3c24xx_setup_clocks
  S3C24XX: remove plat-s3c24xx/clock.c

 arch/arm/mach-s3c2412/clock.c              |    1 +
 arch/arm/mach-s3c2412/s3c2412.c            |    7 ++-
 arch/arm/mach-s3c2416/clock.c              |    6 --
 arch/arm/mach-s3c2443/clock.c              |    7 ---
 arch/arm/plat-s3c24xx/Makefile             |    1 -
 arch/arm/plat-s3c24xx/clock.c              |   59 ------------------------
 arch/arm/plat-s3c24xx/s3c2410-clock.c      |   15 ++++++
 arch/arm/plat-s3c24xx/s3c2443-clock.c      |   69 +++++++++++++++++++---------
 arch/arm/plat-samsung/include/plat/clock.h |    1 -
 9 files changed, 69 insertions(+), 97 deletions(-)
 delete mode 100644 arch/arm/plat-s3c24xx/clock.c

-- 
1.7.5.4
