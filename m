From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Jun 2015 15:10:07 +0100
Subject: [PATCH] arm64: vdso: work-around broken ELF toolchains in Makefile
In-Reply-To: <1434718593-3648-1-git-send-email-will.deacon@arm.com>
References: <1434718593-3648-1-git-send-email-will.deacon@arm.com>
Message-ID: <20150619141007.GB20798@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 19, 2015 at 01:56:33PM +0100, Will Deacon wrote:
> When building the kernel with a bare-metal (ELF) toolchain, the -shared
> option may not be passed down to collect2, resulting in silent corruption
> of the vDSO image (in particular, the DYNAMIC section is omitted).
> 
> The effect of this corruption is that the dynamic linker fails to find
> the vDSO symbols and libc is instead used for the syscalls that we
> intended to optimise (e.g. gettimeofday). Functionally, there is no
> issue as the sigreturn trampoline is still intact and located by the
> kernel.
> 
> This patch fixes the problem by explicitly passing -shared to the linker
> when building the vDSO.
> 
> Cc: <stable@vger.kernel.org>
> Reported-by: Szabolcs Nagy <Szabolcs.Nagy@arm.com>
> Reported-by: James Greenlaigh <james.greenhalgh@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Queued for 4.2. Thanks.

-- 
Catalin
