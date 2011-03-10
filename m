From: madhavi.linux@gmail.com (Madhavi Manchala)
Date: Thu, 10 Mar 2011 20:52:55 +0530
Subject: error: #error Unknown data abort handler type from glue.h file
Message-ID: <AANLkTikry0Yb_RwngKzFO3yDK6vppoT+eK+dP2bs6Wzz@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear All,

When I looked into the linux-2.6.36/arch/arm directory, I did not find
the mach-s3c2510/s3c2510a directory for Samsung s3c2510a MCU. When I
asked the same in the ARM forum, they told me that this MCU is a
NO-MMU based MCU and in the current kernel there was no much support
for it. For complete details, please look at the following link.
http://comments.gmane.org/gmane.linux.ports.arm.kernel/108351

So, I started developing the architecture files for my MCU i.e.
Samsung S3C2510A. However, when I am trying to build the kernel after
adding the support for S3C2510A processor, I am getting the following
error.

  CC      init/main.o
In file included from
/home/madhavi/linux-2.6.36/arch/arm/include/asm/cacheflush.h:15:0,
                 from include/linux/highmem.h:9,
                 from include/linux/pagemap.h:10,
                 from include/linux/mempolicy.h:70,
                 from init/main.c:50:
/home/madhavi/linux-2.6.36/arch/arm/include/asm/glue.h:119:2: error:
#error Unknown data abort handler type
make[6]: *** [init/main.o] Error 1
make[5]: *** [init] Error 2
make[5]: Leaving directory `/home/madhavi/linux-2.6.36'
make[4]: *** [/home/madhavi/linux-2.6.36/.image] Error 2

When I looked into the sources of the /arch/arm/include/asm/glue.h
file, none of the macro defines the CPU_DABORT_HANDLER. From the
arch/arm/Makefile the abort handler for no-mmu based CPUs is as
follows.

obj-$(CONFIG_CPU_ABRT_NOMMU)	+= abort-nommu.o

In my case, the CONFIG_CPU_ABRT_NOMMU is defined in .config file to y.
My question is, why again it is trying to check the abort handler from
glue.h file? Shall I add a new macro in the glue.h file for defining
the CPU_DABORT_HANDLER based on this new MCU (Samsung S3C2510A)?

Any ideas / hits would be appreciated.

Thanks for your help.

Regards,
Madhavi M.
