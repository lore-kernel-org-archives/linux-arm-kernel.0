From: slash.tmp@free.fr (Mason)
Date: Fri, 25 Sep 2015 11:27:47 +0200
Subject: Steps to submit a new arch/arm port
In-Reply-To: <2206647.QPrIpE2UC0@wuerfel>
References: <56001B78.2090001@free.fr> <2206647.QPrIpE2UC0@wuerfel>
Message-ID: <56051393.2080709@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/09/2015 17:49, Arnd Bergmann wrote:

> - Makefile.boot should not be needed

$ cat arch/arm/mach-tangox/Makefile.boot
  zreladdr-y		+= 0x80008000
params_phys-y		:= 0x80000100
initrd_phys-y		:= 0x80800000

I see that defining ARCH_MULTIPLATFORM selects AUTO_ZRELADDR
Is that what is supposed to make Makefile.boot not required?

If I remove Makefile.boot altogether, 'make uImage' fails with

  Kernel: arch/arm/boot/Image is ready
  Kernel: arch/arm/boot/Image is ready
  Kernel: arch/arm/boot/zImage is ready
  Kernel: arch/arm/boot/Image is ready
  Kernel: arch/arm/boot/zImage is ready
multiple (or no) load addresses: 
This is incompatible with uImages
Specify LOADADDR on the commandline to build an uImage
make[1]: *** [arch/arm/boot/uImage] Error 1
make: *** [uImage] Error 2


On an unrelated topic, someone wrote
select CPU_USE_DOMAINS if MMU
in my platform Kconfig. But looking at arm/mm/Kconfig,
it looks like it is not set for other V7 platforms.
Is this an obsolete feature that I should remove?

Regards.
