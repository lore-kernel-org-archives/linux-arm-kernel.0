From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sat, 20 Aug 2011 17:57:56 +0200
Subject: [PATCH 0/4] S3C2416: Enable IIS and HSSPI clocks
Message-ID: <201108201757.56483.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S3C2416/2450 (probably S3C2443 too) can use the newer style
kernel-drivers made for S3C64xx and above for their I2S and
HS-SPI controllers.

So as a first step in this direction, these patches add their
respective clocks.

The I2S clocks were simply moved from S3C2443 to s3c2443-clock.c
as they are identical on all 3 platforms.

The same is true for the HSSPI pclk which is added to s3c2443-clock.c,
as it was not defined at all yet.

The HSSPI sclk is different between 2443 and 2416 and is therefore
added to mach-s3c2416/clock.c


Heiko Stuebner (4):
  S3C2443: Move i2s clock definitions to common code
  S3C2443: Define constant for HSSPI pclk
  S3C2416: Add HSSPI clock sourced from EPLL
  S3C2443: Add hsspi-clock from pclk

 .../mach-s3c2410/include/mach/regs-s3c2443-clock.h |    1 +
 arch/arm/mach-s3c2416/clock.c                      |   26 +++++++++
 arch/arm/mach-s3c2443/clock.c                      |   53 ------------------
 arch/arm/plat-s3c24xx/s3c2443-clock.c              |   58 ++++++++++++++++++++
 4 files changed, 85 insertions(+), 53 deletions(-)

-- 
1.7.2.3
