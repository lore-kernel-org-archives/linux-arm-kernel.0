From: robherring2@gmail.com (Rob Herring)
Date: Tue, 09 Apr 2013 08:09:54 -0500
Subject: multi-platform broken in -next
Message-ID: <51641322.6000508@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

Looks like cns3xxx changes broke multi-platform builds in todays
linux-next tree:

+ make -j4 ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- zImage dtbs
scripts/kconfig/conf --silentoldconfig Kconfig
arch/arm/mach-cns3xxx/Kconfig:2:warning: choice value used outside its
choice group
arch/arm/mach-bcm2835/Kconfig:2:warning: choice value used outside its
choice group
arch/arm/Kconfig:287:error: recursive dependency detected!
arch/arm/Kconfig:287:	choice <choice> contains symbol ARCH_CNS3XXX
arch/arm/Kconfig:366:	symbol ARCH_CNS3XXX depends on ARCH_MULTI_V6
arch/arm/Kconfig:933:	symbol ARCH_MULTI_V6 depends on ARCH_MULTIPLATFORM
arch/arm/Kconfig:292:	symbol ARCH_MULTIPLATFORM is part of choice <choice>
  WRAP    arch/arm/include/generated/asm/auxvec.h
  WRAP    arch/arm/include/generated/asm/bitsperlong.h

Rob
