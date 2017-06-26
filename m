From: will.deacon@arm.com (Will Deacon)
Date: Mon, 26 Jun 2017 10:15:43 +0100
Subject: [PATCH] arm64: pass endianness info to sparse
In-Reply-To: <20170624154211.61472-1-luc.vanoostenryck@gmail.com>
References: <20170624154211.61472-1-luc.vanoostenryck@gmail.com>
Message-ID: <20170626091542.GA1691@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 24, 2017 at 05:42:11PM +0200, Luc Van Oostenryck wrote:
> ARM64 depends on the macro __AARCH64EB__ being defined or not
> to correctly select or define endian-specific macros, structures
> or pieces of code.
> 
> This macro is predefined by the compiler but sparse knows nothing
> about it and thus may pre-process files differently from what
> gcc would.
> 
> Fix this by passing '-D__AARCH64EL__' or '-D__AARCH64EB__' to
> sparse depending of the endianness of the kernel, like defined
> by GCC.
> 
> Note: In most case it won't change anything since most arm64 use
>       little-endian (but an allyesconfig would use big-endian!).
> 
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> CC: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  arch/arm64/Makefile | 2 ++
>  1 file changed, 2 insertions(+)

Thanks, I'll pick this up.

Will
