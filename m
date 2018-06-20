From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 20 Jun 2018 16:32:08 +0100
Subject: [PATCH 2/3] arm64: Remove unnecessary ISBs from set_{pte, pmd,
 pud}
In-Reply-To: <1529412495-17525-3-git-send-email-will.deacon@arm.com>
References: <1529412495-17525-1-git-send-email-will.deacon@arm.com>
 <1529412495-17525-3-git-send-email-will.deacon@arm.com>
Message-ID: <20180620153208.qqtd35tci2hkwxmm@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2018 at 01:48:14PM +0100, Will Deacon wrote:
> Commit 7f0b1bf04511 ("arm64: Fix barriers used for page table modifications")
> fixed a reported issue with fixmap page-table entries not being visible
> to the walker due to a missing DSB instruction. At the same time, it added
> ISB instructions to the arm64 set_{pte,pmd,pud} functions, which are not
> required by the architecture and make little sense in isolation.
> 
> Remove the redundant ISBs.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Leif Lindholm <leif.lindholm@linaro.org>
> Cc: Steve Capper <steve.capper@linaro.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Since I no longer remember the reason I added the ISBs in the first
place:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
