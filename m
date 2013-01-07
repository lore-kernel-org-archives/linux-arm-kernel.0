From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 07 Jan 2013 13:27:40 +0100
Subject: [PATCH 1/4] arm: mvebu: limit OpenBlocks AX3-4 to 1 GB of RAM
In-Reply-To: <20130107113411.GV3392@lunn.ch>
References: <1357315498-4570-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <50E710CB.8070007@lunn.ch> <20130104183139.20492204@skate>
 <50E71356.3030203@lunn.ch> <20130104190345.460151d1@skate>
 <50E9EE7A.1080301@free-electrons.com> <20130106235312.0839a879@skate>
 <20130107094747.GR3392@lunn.ch> <20130107110712.GT3392@lunn.ch>
 <20130107122613.64f4ace5@skate> <20130107113411.GV3392@lunn.ch>
Message-ID: <50EABF3C.9020907@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/07/2013 12:34 PM, Andrew Lunn wrote:
>> Image is also with an initramfs + appended DTB. My boot command is:
>>
>> tftp 1000000 192.168.0.14:uImage.armada-xp-openblocks-ax3-4; bootm
>>
>> So I'm loading to a different address than you.
> 
> Hi Thomas
> 
> Uboot tells me:
> 
> DRAM:   3 GB
>        CS 0: base 0x00000000 size  1 GB
>        CS 2: base 0x40000000 size  1 GB
>        CS 3: base 0x80000000 size  1 GB
>        Addresses 14M - 0M are saved for the U-Boot usage.
> 
> 1000000 would be towards the beginning of this area reserved for uboot.
> 
> Could you try moving to somewhere outside of the first 14Mbytes and
> see if that helps.

I tried to load the kernel at the same address as you (0x80000000) and
it still hanged after 3 or 4 boots.

Now we have to be sure that we use the same .config and the same compiler.
My compiler is :
arm-linux-gnueabi-gcc -v
Using built-in specs.
COLLECT_GCC=arm-linux-gnueabi-gcc
COLLECT_LTO_WRAPPER=/usr/lib/gcc/arm-linux-gnueabi/4.6/lto-wrapper
Target: arm-linux-gnueabi
Configured with: ../src/configure -v --with-pkgversion='Ubuntu/Linaro 4.6.3-1ubuntu5' --with-bugurl=file:///usr/share/doc/gcc-4.6/README.Bugs --enable-languages=c,c++,fortran,objc,obj-c++
--prefix=/usr --program-suffix=-4.6 --enable-shared --enable-linker-build-id --with-system-zlib --libexecdir=/usr/lib --without-included-gettext --enable-threads=posix
--with-gxx-include-dir=/usr/arm-linux-gnueabi/include/c++/4.6.3 --libdir=/usr/lib --enable-nls --enable-clocale=gnu --enable-libstdcxx-debug --enable-libstdcxx-time=yes
--enable-gnu-unique-object --enable-plugin --enable-objc-gc --enable-multilib --disable-sjlj-exceptions --with-arch=armv7-a --with-float=softfp --with-fpu=vfpv3-d16 --with-mode=thumb
--disable-werror --enable-checking=release --build=i686-linux-gnu --host=i686-linux-gnu --target=arm-linux-gnueabi --program-prefix=arm-linux-gnueabi-
--includedir=/usr/arm-linux-gnueabi/include --with-headers=/usr/arm-linux-gnueabi/include --with-libs=/usr/arm-linux-gnueabi/lib
Thread model: posix
gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5)



> 
>     Thanks
> 	Andrew
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
