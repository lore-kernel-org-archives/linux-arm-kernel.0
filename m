From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 28 Aug 2012 16:30:45 -0700
Subject: [PATCH 1/2] ARM: S3C64XX: Update configuration for WM5102 module
 on Cragganmore
In-Reply-To: <20120823152031.GH7995@opensource.wolfsonmicro.com>
References: <1344535549-4371-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <0db901cd76b4$7daf1730$790d4590$%kim@samsung.com>
 <20120810100713.GH24328@opensource.wolfsonmicro.com>
 <0eff01cd777f$4c9d1f90$e5d75eb0$%kim@samsung.com>
 <20120813122359.GA13446@opensource.wolfsonmicro.com>
 <1d5901cd8114$023550f0$069ff2d0$%kim@samsung.com>
 <20120823152031.GH7995@opensource.wolfsonmicro.com>
Message-ID: <503D54A5.8010003@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/23/12 08:20, Mark Brown wrote:
> On Thu, Aug 23, 2012 at 06:45:19PM +0900, Kukjin Kim wrote:
>
>> Yeah, actually SoC defconfig in mainline doesn't cover _real_ requirements
>> for (mass) product. But I think, it's time we need to sort out the
>> defconfigs so that we could use them efficiently on product. BTW, if
>> enabling board in defconfig, at least, unexpected build breakages could be
>> detected by testing defconfig before merge for mainline...
>
> Right, sure.  I guess the main thing I'm saying here is that I don't
> mind what happens here, it's certainly no problem for me turn them on in
> the build if that's what people wants.
>
Hmm...I want? :)

--->

From: Kukjin Kim <kgene.kim@samsung.com>
Subject: [PATCH] ARM: s3c6400_defconfig: enable more boards in defconfig

This enables all of s3c64xx boards in the s3c6400_defconfig.
In this time, MINI6410, REAL6410, and WLF_CRAGG_6410 are
added in the defconfig.

Cc: Darius Augulis <augulis.darius@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
  arch/arm/configs/s3c6400_defconfig |    3 +++
  1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/s3c6400_defconfig 
b/arch/arm/configs/s3c6400_defconfig
index ba6a515..3a186d6 100644
--- a/arch/arm/configs/s3c6400_defconfig
+++ b/arch/arm/configs/s3c6400_defconfig
@@ -9,11 +9,14 @@ CONFIG_ARCH_S3C64XX=y
  CONFIG_S3C_BOOT_ERROR_RESET=y
  CONFIG_MACH_SMDK6400=y
  CONFIG_MACH_ANW6410=y
+CONFIG_MACH_MINI6410=y
+CONFIG_MACH_REAL6410=y
  CONFIG_MACH_SMDK6410=y
  CONFIG_MACH_NCP=y
  CONFIG_MACH_HMT=y
  CONFIG_MACH_SMARTQ5=y
  CONFIG_MACH_SMARTQ7=y
+CONFIG_MACH_WLF_CRAGG_6410=y
  CONFIG_CPU_32v6K=y
  CONFIG_AEABI=y
  CONFIG_CMDLINE="console=ttySAC0,115200 root=/dev/ram init=/linuxrc 
initrd=0x51000000,6M ramdisk_size=6144"
-- 

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
