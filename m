From: ramana.radhakrishnan@foss.arm.com (Ramana Radhakrishnan)
Date: Thu, 17 Mar 2016 16:18:12 +0000
Subject: ARMv4 (not v4t) marked obsolete in gcc-6
In-Reply-To: <201603101013.04618.arnd@arndb.de>
References: <201603101013.04618.arnd@arndb.de>
Message-ID: <56EAD8C4.2030506@foss.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org




On 10/03/16 09:13, Arnd Bergmann wrote:
> I've found out that ARMv3 and ARMv4 is now on track to get removed from gcc in the future,
> so I'm trying to alert everyone that I have knowledge of using ARMv4 based platforms that
> we currenly support in the Linux kernel.
> 
> The architecture has been declared obsolete here: https://gcc.gnu.org/gcc-6/changes.html
> and it will be removed in the following release (gcc-7) one year later, unless someone
> raises concerns over it.

Support for armv4 has been deprecated but not yet obsoleted. We'd like to remove support for it in a future release of the compiler which could be as early as GCC 7 depending on the feedback we receive over the coming weeks / months. Removing support for armv4 will allow us to assume interworking by default which helps in cleaning up and simplifying the ARM backend. Further no one is really testing support for anything earlier than v4t really in the GCC community. While we would like to be cautious about removing support for armv4 from the tools, we think 2016 is a good time to start asking questions around removing support for this in the backend of the compiler.

Folks building the kernel / applications that require armv4 support can continue using the linker option --fix-v4bx which should take care of the fixups. Ideally we would have liked to have removed support for v4 in binutils as well at some point of time in the future, but it appears as though there is a significant community of users who would like to build kernels / other apps for v4 based systems - thus I suspect that support will live for quite a while as it also keeps old assembler code going but ends up simplifying the compiler code base.

In terms of registering opinions on keeping support for armv4 going, we'd prefer folks to discuss these with posts onto gcc at gcc.gnu.org describing their reasons for the same. There is a maintenance cost on keeping support for this going as there is a quite a bit of special casing for interworking vs non-interworking targets that we would like to clean up in the future once support goes out. At this point of time I haven't seen any good reasons to keep support going for armv4 in the *compiler*, since the linker option is available.


Thanks,
Ramana
