From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 8 Dec 2010 13:37:19 +0000
Subject: Linux kernel compilation failed with error: FPA is unsupported
	in the AAPCS
In-Reply-To: <AANLkTikjG0DYxcG9Mo6jVKs2jKe7-uGL6eh2jGF10dpD@mail.gmail.com>
References: <AANLkTikjG0DYxcG9Mo6jVKs2jKe7-uGL6eh2jGF10dpD@mail.gmail.com>
Message-ID: <20101208133719.GC2716@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 08, 2010 at 01:04:17PM +0000, Prasad Joshi wrote:
> Hello All,
> 
> I am trying to compile the linux 2.6.36 kernel for arm-linux. This is
> the error I am getting during compilation.
> 
> clfs at prasad-desktop:/mnt/clfs/sources/linux-2.6.36$ make
> ARCH=${CLFS_ARCH} CROSS_COMPILE=${CLFS_TARGET}- zImage modules
>   CHK     include/linux/version.h
>   CHK     include/generated/utsrelease.h
> make[1]: `include/generated/mach-types.h' is up to date.
>   CC      kernel/bounds.s
> kernel/bounds.c:1:0: error: FPA is unsupported in the AAPCS
> make[1]: *** [kernel/bounds.s] Error 1
> make: *** [prepare0] Error 2
> 
> These are the environment variables
> export BUILD="-mabi=arm-linux"
> export CLFS_ARCH="arm"
> export CLFS_TARGET="arm-unknown-linux-uclibc"
> export CLFS_HOST="x86_64-cross-linux-gnu"
> export CLFS_ENDIAN="little"
> export CC="arm-unknown-linux-uclibc-gcc"
> export CXX="arm-unknown-linux-uclibc-g++"
> export AR="arm-unknown-linux-uclibc-ar"
> export AS="arm-unknown-linux-uclibc-as"
> export LD="arm-unknown-linux-uclibc-ld"
> export RANLIB="arm-unknown-linux-uclibc-ranlib"
> export READELF="arm-unknown-linux-uclibc-readelf"
> export STRIP="arm-unknown-linux-uclibc-strip"
> 
> clfs at prasad-desktop:/mnt/clfs/sources/linux-2.6.36$
> arm-unknown-linux-uclibc-gcc -v
> Using built-in specs.
> COLLECT_GCC=arm-unknown-linux-uclibc-gcc
> COLLECT_LTO_WRAPPER=/mnt/clfs/cross-tools/libexec/gcc/arm-unknown-linux-uclibc/4.5.1/lto-wrapper
> Target: arm-unknown-linux-uclibc
> Configured with: ../gcc-4.5.1/configure --prefix=/mnt/clfs/cross-tools
> --build=x86_64-cross-linux-gnu --host=x86_64-cross-linux-gnu
> --target=arm-unknown-linux-uclibc --with-sysroot=/mnt/clfs
> --disable-nls --disable-shared --with-mpfr=/mnt/clfs/cross-tools
> --with-gmp=/mnt/clfs/cross-tools --without-headers --with-newlib
> --disable-decimal-float --disable-libgomp --disable-libmudflap
> --disable-libssp --disable-threads --enable-languages=c :
> (reconfigured) ../gcc-4.5.1/configure --prefix=/mnt/clfs/cross-tools
> --build=x86_64-cross-linux-gnu --target=arm-unknown-linux-uclibc
> --host=x86_64-cross-linux-gnu --with-sysroot=/mnt/clfs --disable-nls
> --enable-shared --enable-languages=c --enable-c99 --enable-long-long
> --with-mpfr=/mnt/clfs/cross-tools --with-gmp=/mnt/clfs/cross-tools
> Thread model: posix
> gcc version 4.5.1 (GCC)
If your kernel is configured for EABI (CONFIG_AEABI=y) then you'll need a 
compiler built for EABI. You can find one at 
http://kernel.org/pub/tools/crosstool/files/bin/ that doesn't have a libc.

Jamie
