From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 16 Sep 2015 16:54:28 +0100
Subject: [PATCH] arm64: errata: add module build workaround for erratum
 #843419
In-Reply-To: <1442402197-20306-1-git-send-email-will.deacon@arm.com>
References: <1442402197-20306-1-git-send-email-will.deacon@arm.com>
Message-ID: <20150916155428.GH25444@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2015 at 12:16:37PM +0100, Will Deacon wrote:
> Cortex-A53 processors <= r0p4 are affected by erratum #843419 which can
> lead to a memory access using an incorrect address in certain sequences
> headed by an ADRP instruction.
> 
> There is a linker fix to generate veneers for ADRP instructions, but
> this doesn't work for kernel modules which are built as unlinked ELF
> objects.
> 
> This patch adds a new config option for the erratum which, when enabled,
> builds kernel modules with the mcmodel=large flag. This uses absolute
> addressing for all kernel symbols, thereby removing the use of ADRP as
> a PC-relative form of addressing. The ADRP relocs are removed from the
> module loader so that we fail to load any potentially affected modules.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

I don't particularly like but, well...

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
