From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sun, 18 Sep 2011 22:41:48 +0200
Subject: [PATCH v2 0/7] S3C2443/S3C2416: Implement support for ADC
Message-ID: <201109182241.48858.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The adc blocks of S3C2443 and S3C2416/2450 differ in some regards
from previous (S3C2410, etc) and later (S3C64XX, S5P) SoCs.

Defining more TYPE_ADCVx types for these SoCs would complicate the
necessary checks a lot. Therefore I opted for the use of quirk
constants which can describe the features of the respective adc
block and can be tested directly against.

This patch series replaces the type checks with checks for specific
quirks and adds support for S3C2443 and S3C2416/2450 on top of this.

Each patch was compile tested, and I tried to only do "equivalent
transforms" for the stuff on lower levels. But as I have only
access to S3C2416 hardware, real life testing happened only there.

Changes since v1:
added a wrap for a line over 80 and moved the adc_setname call
to the s3c24XX.c files where all the other names are set.

Heiko Stuebner (7):
  S3C2443/S3C2416: Add adc registers
  s3c-adc: describe features via quirk constants
  s3c-adc: Replace TYPE_ADCVx conditionals with quirks
  s3c-adc: Fix mux bit modification in s3c_adc_select
  S3C24XX: Allow overriding of adc device name
  s3c-adc: Add support for S3C2443
  s3c-adc: Add support for S3C2416/S3C2450

 arch/arm/mach-s3c2416/s3c2416.c               |    3 +
 arch/arm/mach-s3c2443/s3c2443.c               |    3 +
 arch/arm/plat-samsung/adc.c                   |   90 +++++++++++++++++++-----
 arch/arm/plat-samsung/include/plat/adc-core.h |    2 +-
 arch/arm/plat-samsung/include/plat/regs-adc.h |    3 +
 5 files changed, 80 insertions(+), 20 deletions(-)

-- 
1.7.2.3
