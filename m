From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 22 Nov 2011 10:52:38 +0100
Subject: 3.2-rc2 compile error
In-Reply-To: <201111221034.06418.tim01@iss.tu-darmstadt.de>
References: <201111221034.06418.tim01@iss.tu-darmstadt.de>
Message-ID: <20111122095238.GE19986@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tim,

On Tue, Nov 22, 2011 at 10:34:05AM +0100, Tim Sander wrote:
> Hi
> 
> I've just hit a compile error with the appended kernel config:
> cd /home/sander/speedy/trunk/ptx/platform-pmx-one/build-target/linux-linux && PATH=/home/sander/speedy/trunk/ptx/platform-pmx-one/sysroot-
> cross/bin:/home/sander/speedy/trunk/ptx/platform-pmx-one/sysroot-cross/sbin:$PATH KCONFIG_NOTIMESTAMP=1 make \
>                 -j16 HOSTCC=gcc ARCH=arm CROSS_COMPILE=arm-1136jfs-linux-gnueabi- INSTALL_MOD_PATH=/home/sander/speedy/trunk/ptx/platform-pmx-
> one/packages/linux-linux PTX_KERNEL_DIR=/home/sander/speedy/trunk/ptx/platform-pmx-one/build-target/linux-linux 
> CONFIG_DEBUG_SECTION_MISMATCH=y DEPMOD=/home/sander/speedy/trunk/ptx/platform-pmx-one/sysroot-cross/sbin/arm-1136jfs-linux-gnueabi-depmod 
> uImage "modules"
> make[1]: Entering directory `/home/sander/speedy/trunk/ptx/kernel/linux'
>   CHK     include/linux/version.h
>   CHK     include/generated/utsrelease.h
> make[2]: `include/generated/mach-types.h' is up to date.
>   CALL    scripts/checksyscalls.sh
> <stdin>:1562:2: warning: #warning syscall process_vm_readv not implemented
> <stdin>:1566:2: warning: #warning syscall process_vm_writev not implemented
>   CHK     include/generated/compile.h
>   CHK     kernel/config_data.h
>   GEN     .version
>   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> arch/arm/mach-imx/built-in.o: In function `imx31_soc_init':
> /home/sander/speedy/trunk/ptx/platform-pmx-one/build-target/linux-linux/arch/arm/mach-imx/mm-imx3.c:186: undefined reference to `mx31_revision'
> make[1]: *** [.tmp_vmlinux1] Error 1
> make[1]: Leaving directory `/home/sander/speedy/trunk/ptx/kernel/linux'
> make: *** [/home/sander/speedy/trunk/ptx/platform-pmx-one/state/kernel.compile] Error 2
You want the first patch of

http://mid.gmane.org/20111122090622.GC19986 at pengutronix.de

Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
