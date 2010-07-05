From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 05 Jul 2010 14:24:03 +0200
Subject: Some benchmarks on ARM
In-Reply-To: <4C2E4D59.8030300@gmail.com>
References: <20100702180257.GA8767@pengutronix.de> <4C2E4D59.8030300@gmail.com>
Message-ID: <4C31CEE3.2050202@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Magnus Lilja wrote:
> Hi Robert,
> 
> On 2010-07-02 20:02, Robert Schwebel wrote:
>> Hi,
>>
>> We have recently made some benchmarks, in order to get a little bit
>> better fealing about where ARM cpus are today, especially when it comes
>> to the "recent" ones, and in comparism to the Atom. So we collected a
>> few benchmarks (most from lmbench) and did some actual measurements.
>>
>> Here is a little article:
>> http://www.pengutronix.de/development/kernel/arm-benchmarks-20100702_en.html
>>
>> I'm pretty sure that there are quite a few things where people on ALKML
>> have good ideas where the effects come from or how to improve the
>> methodology - so I'd be glad to get some feedback from the community!
> 
> 

> It would be nice if you could add the exact command lines you used
> for the different tests so it's easy to run the same tests on other
> boards as well. I suppose you added some flag to gcc to make use of
> the floating point hardware in i.MX35?

We used a compiler generating hardware floating point instruction by
default:

gcc was configured with:
"--with-float=softfp --with-fpu=vfp --with-cpu=arm1136jf-s"

here the complete output of gcc -v:
Using built-in specs.
Target: arm-1136jfs-linux-gnueabi
Configured with:
/home/frogger/pengutronix/toolchain/releases/OSELAS.Toolchain-1.99.3/platform-arm-1136jfs-linux-gnueabi-gcc-4.3.2-glibc-2.8-binutils-2.19-kernel-2.6.27-sanitized/build-cross/gcc-4.3.2/configure
--target=arm-1136jfs-linux-gnueabi
--with-sysroot=/home/frogger/pengutronix/toolchain/releases/OSELAS.Toolchain-1.99.3/inst/opt/OSELAS.Toolchain-1.99.3/arm-1136jfs-linux-gnueabi/gcc-4.3.2-glibc-2.8-binutils-2.19-kernel-2.6.27-sanitized/sysroot-arm-1136jfs-linux-gnueabi
--disable-multilib --with-float=softfp --with-fpu=vfp
--with-cpu=arm1136jf-s --enable-__cxa_atexit --disable-sjlj-exceptions
--disable-nls --disable-decimal-float --disable-fixed-point
--disable-win32-registry --enable-symvers=gnu
--with-pkgversion=OSELAS.Toolchain-1.99.3
--with-gmp=/home/frogger/pengutronix/toolchain/releases/OSELAS.Toolchain-1.99.3/platform-arm-1136jfs-linux-gnueabi-gcc-4.3.2-glibc-2.8-binutils-2.19-kernel-2.6.27-sanitized/sysroot-host
--with-mpfr=/home/frogger/pengutronix/toolchain/releases/OSELAS.Toolchain-1.99.3/platform-arm-1136jfs-linux-gnueabi-gcc-4.3.2-glibc-2.8-binutils-2.19-kernel-2.6.27-sanitized/sysroot-host
--prefix=/home/frogger/pengutronix/toolchain/releases/OSELAS.Toolchain-1.99.3/inst/opt/OSELAS.Toolchain-1.99.3/arm-1136jfs-linux-gnueabi/gcc-4.3.2-glibc-2.8-binutils-2.19-kernel-2.6.27-sanitized
--enable-languages=c,c++ --enable-threads=posix --enable-c99
--enable-long-long --enable-libstdcxx-debug --enable-profile
--enable-shared --enable-libssp --enable-checking=release
Thread model: posix
gcc version 4.3.2 (OSELAS.Toolchain-1.99.3)

cheers, Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 260 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100705/3df9031f/attachment.sig>
