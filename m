From: will.deacon@arm.com (Will Deacon)
Date: Fri, 8 Jan 2016 15:59:32 +0000
Subject: [PATCH] arm64: split elf relocs into a separate header.
In-Reply-To: <1452256909-30881-1-git-send-email-mark.rutland@arm.com>
References: <20160108123614.GC3097@leverpostej>
 <1452256909-30881-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20160108155932.GE11228@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2016 at 12:41:49PM +0000, Mark Rutland wrote:
> Currently asm/elf.h contains a mixture of simple constants, C structure
> definitions, and some constants defined terms of constants from other
> headers (which are themselves mixtures).
> 
> To enable the use of AArch64 ELF reloc constants from assembly code (s
> we will need for relocatable kernel support), we need an include without
> C structure definitions or incldues of other files with such
> definitions.
> 
> This patch factors out the relocs into a new header specifically for ELF
> reloc types.

Does #ifdef __ASSEMBLY__ not do the trick?

Will
