From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 15 Aug 2011 17:51:33 +0100
Subject: [PATCH v7 09/16] ARM: LPAE: MMU setup for the 3-level page
	table format
In-Reply-To: <1312988619-16804-10-git-send-email-catalin.marinas@arm.com>
References: <1312988619-16804-1-git-send-email-catalin.marinas@arm.com>
	<1312988619-16804-10-git-send-email-catalin.marinas@arm.com>
Message-ID: <20110815165133.GF3392@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 04:03:32PM +0100, Catalin Marinas wrote:
> This patch adds the MMU initialisation for the LPAE page table format.
> The swapper_pg_dir size with LPAE is 5 rather than 4 pages. A new
> proc-v7lpae.S file contains the initialisation, context switch and
> save/restore code for ARMv7 with the LPAE. The TTBRx split is based on
> the PAGE_OFFSET with TTBR1 used for the kernel mappings. The 36-bit
> mappings (supersections) and a few other memory types in mmu.c are
> conditionally compiled.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Following the split of this patch, it becomes:

8<--------------------
