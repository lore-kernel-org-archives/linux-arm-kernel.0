From: tony@bakeyournoodle.com (Tony Breeds)
Date: Fri, 12 Nov 2010 15:45:48 +1100
Subject: [PATCH] ARM: fix build error with GCC 4.5.0
In-Reply-To: <19668.21026.5416.610777@pilspetsen.it.uu.se>
References: <1288897002-24073-1-git-send-email-rabin@rab.in>
	<yw1xy698ygbx.fsf@unicorn.mansr.com>
	<19667.9199.798932.405415@pilspetsen.it.uu.se>
	<AANLkTinUcS3v57bMLXcHaqC+OGoAqgoK2td-ce3B6FOM@mail.gmail.com>
	<19667.52998.909668.596635@pilspetsen.it.uu.se>
	<AANLkTimkSxWNL+aCALGsf5prBM_RHz0BMHCeNwKrTnfA@mail.gmail.com>
	<19668.21026.5416.610777@pilspetsen.it.uu.se>
Message-ID: <20101112044548.GA19615@ozlabs.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 05, 2010 at 07:51:14PM +0100, Mikael Pettersson wrote:
 
> That's an OABI compiler. You want a compiler configured for
> 
> 	--target=arm-unknown-linux-gnueabi
> 
> and without that --enable-sjlj-exceptions as well.
> 
> OABI is super-legacy and essentially unsupported by current gcc.

The previous compiler was the results of configuring for arm-linux now I have:

$ ./buildall/cross.x86_64/gcc-4.4.5-nolibc/arm-unknown-linux-gnueabi/bin/arm-unknown-linux-gnueabi-gcc -v
Using built-in specs.
Target: arm-unknown-linux-gnueabi
Configured with: /home/tony/buildall/src/gcc/configure --target=arm-unknown-linux-gnueabi --enable-targets=all --prefix=/home/tony/buildall/cross.x86_64/gcc-4.4.5-nolibc/arm-unknown-linux-gnueabi/ --enable-languages=c --with-newlib --without-headers --with-system-libunwind --disable-nls --disable-threads --disable-shared --disable-libmudflap --disable-libssp --disable-libgomp --disable-decimal-float --enable-checking=release --with-mpfr=/home/tony/buildall/src/sys-x86_64 --with-gmp=/home/tony/buildall/src/sys-x86_64 --disable-bootstrap
Thread model: single
gcc version 4.4.5 (GCC) 

Is that correct?


Yours Tony
