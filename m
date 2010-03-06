From: db.pub.mail@gmail.com (dave b)
Date: Sat, 6 Mar 2010 21:24:49 +1100
Subject: weirdness with compiling a 2.6.33 kernel on arm debian
In-Reply-To: <19346.6765.457769.167118@pilspetsen.it.uu.se>
References: <25ae2d691003051958x72040b47g29d842f1d389a6cf@mail.gmail.com>
	<19346.6765.457769.167118@pilspetsen.it.uu.se>
Message-ID: <25ae2d691003060224x67ab1c9au5102c8a22518aff@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I had already reported it to debian -
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=572653

I have cc'ed linux-arm-kernel into this email.



On 6 March 2010 20:03, Mikael Pettersson <mikpe@it.uu.se> wrote:
> dave b writes:
> ?> Hi have now successfully built a 2.6.33 kernel on a linkstation pro
> ?> v2. This is an arm device. It is currently running debian?? lenny
> ?> armel.
> ?>
> ?>
> ?> I compiled?? (make) zImage, then did a make modules which failed on the
> ?> first two rounds of compiling the modules -
> ?>
> ?> "fs/afs/super.c: In function ???afs_test_super???:
> ?> fs/afs/super.c:278: internal compiler error: Segmentation fault
> ?> Please submit a full bug report,
> ?> with preprocessed source if appropriate.
> ?> See <file:///usr/share/doc/gcc-4.3/README.Bugs> for instructions."
> ?> This was the error encountered on the attempt at compiling the
> ?> modules.
> ?>
> ?> "crypto/gcm.c: In function ???crypto_gcm_setauthsize???:
> ?> crypto/gcm.c:152: internal compiler error: Segmentation fault
> ?> Please submit a full bug report,
> ?> with preprocessed source if appropriate.
> ?> See <file:///usr/share/doc/gcc-4.3/README.Bugs> for instructions.
> ?> make[1]: *** [crypto/gcm.o] Error 1"
> ?> This was the error the on the second attempt at compiling the modules.
> ?>
> ?> The 3rd attempt at building the modules was successful...
> ?>
> ?> The device boots and runs fine with this kernel and modules appear to work.
> ?> [root at nas ~]# uname -a
> ?> Linux nas 2.6.33 #1 Fri Mar 5 23:54:51 EST 2010 armv5tel GNU/Linux
> ?>
> ?>
> ?> *SO* is this a gcc bug or is it related to the changes to the build
> ?> process on arm?
> ?>
> ?>
> ?>
> ?> gcc -v
> ?> Using built-in specs.
> ?> Target: arm-linux-gnueabi
> ?> Configured with: ../src/configure -v --with-pkgversion='Debian
> ?> 4.3.2-1.1' --with-bugurl=file:///usr/share/doc/gcc-4.3/README.Bugs
> ?> --enable-languages=c,c++,fortran,objc,obj-c++ --prefix=/usr
> ?> --enable-shared --with-system-zlib --libexecdir=/usr/lib
> ?> --without-included-gettext --enable-threads=posix --enable-nls
> ?> --with-gxx-include-dir=/usr/include/c++/4.3 --program-suffix=-4.3
> ?> --enable-clocale=gnu --enable-libstdcxx-debug --enable-objc-gc
> ?> --enable-mpfr --disable-libssp --disable-sjlj-exceptions
> ?> --enable-checking=release --build=arm-linux-gnueabi
> ?> --host=arm-linux-gnueabi --target=arm-linux-gnueabi
> ?> Thread model: posix
> ?> gcc version 4.3.2 (Debian 4.3.2-1.1)
>
> GCC bug. Report it to Debian, just like it asked you to.
>
> In theory it could be flaky hardware or a kernel/CPU combination
> with cache coherency issues, but in those cases I'd have expected
> many more failures.
>
> The ARM kernel mailing list is linux-arm-kernel at lists.infradead.org.
>
