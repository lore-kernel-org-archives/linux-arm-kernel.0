From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 7 Jan 2013 14:22:09 +0100
Subject: [PATCH 1/4] arm: mvebu: limit OpenBlocks AX3-4 to 1 GB of RAM
In-Reply-To: <50EABF3C.9020907@free-electrons.com>
References: <20130104183139.20492204@skate> <50E71356.3030203@lunn.ch>
 <20130104190345.460151d1@skate>
 <50E9EE7A.1080301@free-electrons.com>
 <20130106235312.0839a879@skate> <20130107094747.GR3392@lunn.ch>
 <20130107110712.GT3392@lunn.ch> <20130107122613.64f4ace5@skate>
 <20130107113411.GV3392@lunn.ch>
 <50EABF3C.9020907@free-electrons.com>
Message-ID: <20130107132209.GW3392@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I tried to load the kernel at the same address as you (0x80000000) and
> it still hanged after 3 or 4 boots.

O.K. Thanks for testing that.
 
> Now we have to be sure that we use the same .config and the same compiler.
> My compiler is :
> arm-linux-gnueabi-gcc -v
> Using built-in specs.
> COLLECT_GCC=arm-linux-gnueabi-gcc
> COLLECT_LTO_WRAPPER=/usr/lib/gcc/arm-linux-gnueabi/4.6/lto-wrapper
> Target: arm-linux-gnueabi
> Configured with: ../src/configure -v --with-pkgversion='Ubuntu/Linaro 4.6.3-1ubuntu5' --with-bugurl=file:///usr/share/doc/gcc-4.6/README.Bugs --enable-languages=c,c++,fortran,objc,obj-c++
> --prefix=/usr --program-suffix=-4.6 --enable-shared --enable-linker-build-id --with-system-zlib --libexecdir=/usr/lib --without-included-gettext --enable-threads=posix
> --with-gxx-include-dir=/usr/arm-linux-gnueabi/include/c++/4.6.3 --libdir=/usr/lib --enable-nls --enable-clocale=gnu --enable-libstdcxx-debug --enable-libstdcxx-time=yes
> --enable-gnu-unique-object --enable-plugin --enable-objc-gc --enable-multilib --disable-sjlj-exceptions --with-arch=armv7-a --with-float=softfp --with-fpu=vfpv3-d16 --with-mode=thumb
> --disable-werror --enable-checking=release --build=i686-linux-gnu --host=i686-linux-gnu --target=arm-linux-gnueabi --program-prefix=arm-linux-gnueabi-
> --includedir=/usr/arm-linux-gnueabi/include --with-headers=/usr/arm-linux-gnueabi/include --with-libs=/usr/arm-linux-gnueabi/lib
> Thread model: posix
> gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5)

I Gregory

I have an older compile:

 arm-linux-gnueabi-gcc -v
Using built-in specs.
Target: arm-linux-gnueabi
Configured with: ../src/configure -v --with-pkgversion='Debian 4.4.5-8' --with-bugurl=file:///usr/share/doc/gcc-4.4/README.Bugs --enable-languages=c,c++,fortran,objc,obj-c++ --prefix=/usr --program-suffix=-4.4 --enable-shared --enable-multiarch --enable-linker-build-id --with-system-zlib --libexecdir=/usr/lib --without-included-gettext --enable-threads=posix --with-gxx-include-dir=/usr/arm-linux-gnueabi/include/c++/4.4.5 --libdir=/usr/lib --enable-nls --enable-clocale=gnu --enable-libstdcxx-debug --enable-objc-gc --disable-sjlj-exceptions --enable-checking=release --program-prefix=arm-linux-gnueabi- --includedir=/usr/arm-linux-gnueabi/include --build=i486-linux-gnu --host=i486-linux-gnu --target=arm-linux-gnueabi --with-headers=/usr/arm-linux-gnueabi/include --with-libs=/usr/arm-linux-gnueabi/lib
Thread model: posix
gcc version 4.4.5 (Debian 4.4.5-8) 

I'm using mvebu_defconfig and the only option i change is
CONFIG_INITRAMFS_SOURCE to point to my rootfs.cpio.gz file.

But of a long shot. Do you have much broadcast traffic in your
network? I just wonder if u-boot has left the ethernet interface
running, and during boot the hardware received a broadcast packet, DMAs
it into memory corrupting something? My board is on a very quiet
subnet, with virtually no broadcasts.

	Andrew
