From: josh.coombs@gmail.com (Josh Coombs)
Date: Fri, 28 Dec 2012 13:19:34 -0500
Subject: Kirkwood issues with 3.8-rc1 - Ooops and hang on reboot
In-Reply-To: <20121228171749.GA6152@lunn.ch>
References: <20121228171749.GA6152@lunn.ch>
Message-ID: <CAMW5UfafiqUSEcsCjoYwYHt8GM3bOpG32=-cE0RoOuLZNg0fdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm using 4.7.2 as packaged by Arch Linux ARM:

[jcoombs at alarm ~]$ gcc -v
Using built-in specs.
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/usr/lib/gcc/armv5tel-unknown-linux-gnueabi/4.7.2/lto-wrapper
Target: armv5tel-unknown-linux-gnueabi
Configured with: /build/src/gcc-4.7.2/configure --prefix=/usr
--libdir=/usr/lib --libexecdir=/usr/lib --mandir=/usr/share/man
--infodir=/usr/share/info --with-bugurl=https://bugs.archlinux.org/
--enable-languages=c,c++,fortran,lto,objc,obj-c++ --enable-shared
--enable-threads=posix --with-system-zlib --enable-__cxa_atexit
--disable-libunwind-exceptions --enable-clocale=gnu
--disable-libstdcxx-pch --enable-libstdcxx-time
--enable-gnu-unique-object --enable-linker-build-id --with-ppl
--enable-cloog-backend=isl --disable-ppl-version-check
--disable-cloog-version-check --enable-lto --enable-gold
--enable-ld=default --enable-plugin --with-plugin-ld=ld.gold
--with-linker-hash-style=gnu --disable-multilib --disable-libssp
--disable-build-with-cxx --disable-build-poststage1-with-cxx
--enable-checking=release --host=armv5tel-unknown-linux-gnueabi
--build=armv5tel-unknown-linux-gnueabi
Thread model: posix
gcc version 4.7.2 (GCC)


On Fri, Dec 28, 2012 at 12:17 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> Hi Josh
>
> What compiler version are you using to get the opps?
>
> I don't see this problem, when building with:
>
> arm-linux-gnueabi-gcc -v
> Using built-in specs.
> Target: arm-linux-gnueabi
> Configured with: ../src/configure -v --with-pkgversion='Debian 4.4.5-8' --with-bugurl=file:///usr/share/doc/gcc-4.4/README.Bugs --enable-languages=c,c++,fortran,objc,obj-c++ --prefix=/usr --program-suffix=-4.4 --enable-shared --enable-multiarch --enable-linker-build-id --with-system-zlib --libexecdir=/usr/lib --without-included-gettext --enable-threads=posix --with-gxx-include-dir=/usr/arm-linux-gnueabi/include/c++/4.4.5 --libdir=/usr/lib --enable-nls --enable-clocale=gnu --enable-libstdcxx-debug --enable-objc-gc --disable-sjlj-exceptions --enable-checking=release --program-prefix=arm-linux-gnueabi- --includedir=/usr/arm-linux-gnueabi/include --build=i486-linux-gnu --host=i486-linux-gnu --target=arm-linux-gnueabi --with-headers=/usr/arm-linux-gnueabi/include --with-libs=/usr/arm-linux-gnueabi/lib
> Thread model: posix
> gcc version 4.4.5 (Debian 4.4.5-8)
>
> The disassembly i get looks similar, but not identical.
>
> BTW:
>
> make drivers/clk/mvebu/clk-gating-ctrl.lst
>
> is useful in situations like this.
>
>    Andrew
