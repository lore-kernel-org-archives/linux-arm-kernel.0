From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 23 Nov 2012 10:37:20 +0900
Subject: [GIT PULL 2/3] Samsung dt-2 for v3.8
Message-ID: <10d501cdc91b$1419fd80$3c4df880$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here is second Samsung DT stuff for v3.8.

This is including power domain DT support for exynos and Google ARM
Chromebook, Snow board and exynos4210-origen updates.

Please pull from:
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next/dt-samsung-2

Note that this is based on previous Samsung DT branch 'next/dt-samsung'

And following, my prefer resolution would be helpful when merge conflict
happens between Samsung dt branch and other Samsung stuff.

8<----------------------------------------------------------
commit 9df1e1c9ce3126321b37b3fae47c343e83982572
Merge: cc24b98 d80162e
Author: Kukjin Kim <kgene.kim@samsung.com>
Date:   Thu Nov 22 16:15:55 2012 +0900

    Merge branch 'next/dt-samsung-2' into for-next
    
    Conflicts:
    	arch/arm/boot/dts/exynos5250-smdk5250.dts
    	arch/arm/boot/dts/exynos5250.dtsi
    	arch/arm/mach-exynos/mach-exynos5-dt.c

diff --cc arch/arm/boot/dts/exynos5250-smdk5250.dts
index 9b9e77f,371182f..5cd16ea
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@@ -102,17 -90,7 +98,17 @@@
  		status = "disabled";
  	};
  
 +	i2c at 12CE0000 {
 +		samsung,i2c-sda-delay = <100>;
 +		samsung,i2c-max-bus-freq = <66000>;
 +
 +		hdmiphy at 38 {
 +			compatible = "samsung,exynos5-hdmiphy";
 +			reg = <0x38>;
 +		};
 +	};
 +
- 	dwmmc_0: dwmmc0 at 12200000 {
+ 	dwmmc0 at 12200000 {
  		num-slots = <1>;
  		supports-highspeed;
  		broken-cd;
diff --cc arch/arm/boot/dts/exynos5250.dtsi
index 733060a,71a3e0b..39fc4bd
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@@ -31,16 -31,10 +31,20 @@@
  		gsc1 = &gsc_1;
  		gsc2 = &gsc_2;
  		gsc3 = &gsc_3;
 +		i2c0 = &i2c_0;
 +		i2c1 = &i2c_1;
 +		i2c2 = &i2c_2;
 +		i2c3 = &i2c_3;
 +		i2c4 = &i2c_4;
 +		i2c5 = &i2c_5;
 +		i2c6 = &i2c_6;
 +		i2c7 = &i2c_7;
 +		i2c8 = &i2c_8;
 +		i2c9 = &i2c_9;
+ 		mshc0 = &dwmmc_0;
+ 		mshc1 = &dwmmc_1;
+ 		mshc2 = &dwmmc_2;
+ 		mshc3 = &dwmmc_3;
  	};
  
  	gic:interrupt-controller at 10481000 {
diff --cc arch/arm/mach-exynos/mach-exynos5-dt.c
index 10f681b,a032678..08f1074
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@@ -52,10 -50,16 +52,20 @@@ static const struct of_dev_auxdata exyn
  				"s3c2440-i2c.0", NULL),
  	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS5_PA_IIC(1),
  				"s3c2440-i2c.1", NULL),
 +	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS5_PA_IIC(2),
 +				"s3c2440-i2c.2", NULL),
+ 	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS5_PA_IIC(3),
+ 				"s3c2440-i2c.3", NULL),
+ 	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS5_PA_IIC(4),
+ 				"s3c2440-i2c.4", NULL),
+ 	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS5_PA_IIC(5),
+ 				"s3c2440-i2c.5", NULL),
+ 	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS5_PA_IIC(6),
+ 				"s3c2440-i2c.6", NULL),
+ 	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS5_PA_IIC(7),
+ 				"s3c2440-i2c.7", NULL),
 +	OF_DEV_AUXDATA("samsung,s3c2440-hdmiphy-i2c", EXYNOS5_PA_IIC(8),
 +				"s3c2440-hdmiphy-i2c", NULL),
  	OF_DEV_AUXDATA("samsung,exynos5250-dw-mshc", EXYNOS5_PA_DWMCI0,
  				"dw_mmc.0", NULL),
  	OF_DEV_AUXDATA("samsung,exynos5250-dw-mshc", EXYNOS5_PA_DWMCI1,
8<--------------------------------------------------------------------

If any problems, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit c47d244a646d08e2161b7fa22c5512e7988762ae:

  ARM: EXYNOS: DT Support for SATA and SATA PHY (2012-11-20 21:02:17 +0900)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next/dt-samsung-2

Doug Anderson (3):
      ARM: dts: Move the dwmmc aliases from smdk5250 dts to exynos
      ARM: dts: Add board dts file for Snow board (ARM Chromebook)
      ARM: dts: Add aliases for i2c controller for exynos4

Olof Johansson (1):
      ARM: EXYNOS: add all i2c busses to auxdata for DT

Tomasz Figa (9):
      ARM: dts: Split memory sections for exynos4210-origen
      ARM: dts: Update for pinctrl-samsung driver for exynos4210-origen
      ARM: dts: Update sdhci nodes for current bindings for
exynos4210-origen
      ARM: dts: Add vmmc fixed voltage regulator for exynos4210-origen
      ARM: EXYNOS: Detect power domain state on registration from DT
      ARM: EXYNOS: Fix power domain name initialization
      ARM: EXYNOS: Bind devices to power domains using DT
      ARM: dts: Set up power domains for exynos4
      ARM: dts: Use drive strength 3 for SD pins for exynos4

 .../bindings/arm/exynos/power_domain.txt           |   15 ++-
 arch/arm/boot/dts/Makefile                         |    3 +-
 arch/arm/boot/dts/cros5250-common.dtsi             |  184
++++++++++++++++++++
 arch/arm/boot/dts/exynos4.dtsi                     |   54 +++++-
 arch/arm/boot/dts/exynos4210-origen.dts            |   54 +++---
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi          |   56 +++---
 arch/arm/boot/dts/exynos4210.dtsi                  |    5 +
 arch/arm/boot/dts/exynos4x12-pinctrl.dtsi          |   56 +++---
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   12 +-
 arch/arm/boot/dts/exynos5250-snow.dts              |   43 +++++
 arch/arm/boot/dts/exynos5250.dtsi                  |   12 +-
 arch/arm/mach-exynos/mach-exynos5-dt.c             |   10 +
 arch/arm/mach-exynos/pm_domains.c                  |   93 ++++++++++-
 13 files changed, 485 insertions(+), 112 deletions(-)
 create mode 100644 arch/arm/boot/dts/cros5250-common.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5250-snow.dts
