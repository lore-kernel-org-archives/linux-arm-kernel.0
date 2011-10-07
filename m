From: tushar.behera@linaro.org (Tushar Behera)
Date: Fri,  7 Oct 2011 17:25:11 +0530
Subject: [PATCH V2 0/2] ARM: S3C2410: Remove section mismatch warning
Message-ID: <1317988513-20800-1-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While compiling with s3c2410_defconfig, we receive 4 section mismatch
warnings.

Patch 1 addresses a couple of warnings related to usb_simtec_init().
Patch 2 addresses mismatch warnings in a couple of mach-*/irq.c files.

Changes for V2:
	* The original patch is splitted to address to different logical
	solutions.
	* __initdata attribute is removed from struct sysdev_driver
	structures and __init attribute is removed from all referenced
	function definitions.

The patches are rebased on v3.1-rc8. They are only build tested,
they are not boot tested on any hardware.


Tushar Behera (2):
  ARM: S3C2410: Add __init attribute to usb_simtec_init()
  ARM: S3C2410: irq: Remove __init attributes to fix compilation
    warning

 arch/arm/mach-s3c2410/usb-simtec.c |    2 +-
 arch/arm/mach-s3c2410/usb-simtec.h |    2 +-
 arch/arm/mach-s3c2416/irq.c        |    4 ++--
 arch/arm/mach-s3c2443/irq.c        |    4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

-- 
1.7.4.1
