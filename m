From: stefan@agner.ch (Stefan Agner)
Date: Thu, 30 Apr 2015 13:44:06 +0200
Subject: Bulid regression with VDSO enabled
Message-ID: <679194be9498c72543073a833e4a1719@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

When enabling VDSO (which is default in multi_v7_defconfig), I get this
linking error on v4.1-rc1 and todays master:

  OBJCOPY arch/arm/vdso/vdso.so
BFD: arch/arm/vdso/vdso.so: Not enough room for program headers, try
linking with -N
arm-angstrom-linux-gnueabi-objcopy:arch/arm/vdso/vdso.so[.hash]: Bad
value
BFD: arch/arm/vdso/vdso.so: Not enough room for program headers, try
linking with -N
arm-angstrom-linux-gnueabi-objcopy:arch/arm/vdso/vdso.so: Bad value
make[2]: *** [arch/arm/vdso/vdso.so] Error 1
make[1]: *** [arch/arm/vdso] Error 2
make[1]: *** Waiting for unfinished jobs....

I'm using GCC 4.8.3 (Linaro GCC 4.8-2014.04) on Fedora 21. Any specific
new requirements to the toolchain or a bug?

--
Stefan
