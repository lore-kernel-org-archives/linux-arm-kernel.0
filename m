From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 28 Dec 2012 18:17:49 +0100
Subject: Kirkwood issues with 3.8-rc1 - Ooops and hang on reboot
Message-ID: <20121228171749.GA6152@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh

What compiler version are you using to get the opps?

I don't see this problem, when building with:

arm-linux-gnueabi-gcc -v
Using built-in specs.
Target: arm-linux-gnueabi
Configured with: ../src/configure -v --with-pkgversion='Debian 4.4.5-8' --with-bugurl=file:///usr/share/doc/gcc-4.4/README.Bugs --enable-languages=c,c++,fortran,objc,obj-c++ --prefix=/usr --program-suffix=-4.4 --enable-shared --enable-multiarch --enable-linker-build-id --with-system-zlib --libexecdir=/usr/lib --without-included-gettext --enable-threads=posix --with-gxx-include-dir=/usr/arm-linux-gnueabi/include/c++/4.4.5 --libdir=/usr/lib --enable-nls --enable-clocale=gnu --enable-libstdcxx-debug --enable-objc-gc --disable-sjlj-exceptions --enable-checking=release --program-prefix=arm-linux-gnueabi- --includedir=/usr/arm-linux-gnueabi/include --build=i486-linux-gnu --host=i486-linux-gnu --target=arm-linux-gnueabi --with-headers=/usr/arm-linux-gnueabi/include --with-libs=/usr/arm-linux-gnueabi/lib
Thread model: posix
gcc version 4.4.5 (Debian 4.4.5-8)

The disassembly i get looks similar, but not identical.

BTW:

make drivers/clk/mvebu/clk-gating-ctrl.lst

is useful in situations like this.

   Andrew
