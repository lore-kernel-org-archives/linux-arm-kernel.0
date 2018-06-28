From: will.deacon@arm.com (Will Deacon)
Date: Thu, 28 Jun 2018 10:39:29 +0100
Subject: [PATCH] arm64: remove no-op -p linker flag
In-Reply-To: <20180627194614.188210-1-ghackmann@google.com>
References: <20180627194614.188210-1-ghackmann@google.com>
Message-ID: <20180628093928.GB10751@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2018 at 12:46:14PM -0700, Greg Hackmann wrote:
> Linking the ARM64 defconfig kernel with LLVM lld fails with the error:
> 
>   ld.lld: error: unknown argument: -p
>   Makefile:1015: recipe for target 'vmlinux' failed
> 
> Without this flag, the ARM64 defconfig kernel successfully links with
> lld and boots on Dragonboard 410c.
> 
> After digging through binutils source and changelogs, it turns out that
> -p is only relevant to ancient binutils installations targeting 32-bit
> ARM.  binutils accepts -p for AArch64 too, but it's always been
> undocumented and silently ignored.  A comment in
> ld/emultempl/aarch64elf.em explains that it's "Only here for backwards
> compatibility".
> 
> Since this flag is a no-op on ARM64, we can safely drop it.

Makes sense:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
