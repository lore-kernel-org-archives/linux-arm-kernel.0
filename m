From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Thu, 30 Apr 2015 09:38:00 -0500
Subject: Bulid regression with VDSO enabled
In-Reply-To: <679194be9498c72543073a833e4a1719@agner.ch>
References: <679194be9498c72543073a833e4a1719@agner.ch>
Message-ID: <55423E48.7000506@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/30/2015 06:44 AM, Stefan Agner wrote:
>   OBJCOPY arch/arm/vdso/vdso.so
> BFD: arch/arm/vdso/vdso.so: Not enough room for program headers, try
> linking with -N
> arm-angstrom-linux-gnueabi-objcopy:arch/arm/vdso/vdso.so[.hash]: Bad
> value
> BFD: arch/arm/vdso/vdso.so: Not enough room for program headers, try
> linking with -N
> arm-angstrom-linux-gnueabi-objcopy:arch/arm/vdso/vdso.so: Bad value
> make[2]: *** [arch/arm/vdso/vdso.so] Error 1
> make[1]: *** [arch/arm/vdso] Error 2
> make[1]: *** Waiting for unfinished jobs....
> 
> I'm using GCC 4.8.3 (Linaro GCC 4.8-2014.04) on Fedora 21. Any specific
> new requirements to the toolchain or a bug?

I've not encountered this before, and I'm not able to recreate it with
that toolchain.

If you're using the Linaro toolchain I would expect the name of objcopy
to be arm-linux-gnueabihf-objcopy, but your log shows
arm-angstrom-linux-gnueabi-objcopy.  What's going on there?
