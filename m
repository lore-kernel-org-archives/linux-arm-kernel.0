From: will.deacon@arm.com (Will Deacon)
Date: Thu, 19 Oct 2017 10:58:38 +0100
Subject: [PATCH] arm64: Update fault_info table with new exception types
In-Reply-To: <1508245890-18093-1-git-send-email-julien.thierry@arm.com>
References: <1508245890-18093-1-git-send-email-julien.thierry@arm.com>
Message-ID: <20171019095837.GC30231@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 02:11:30PM +0100, Julien Thierry wrote:
> Based on: ARM Architecture Reference Manual, ARMv8 (DDI 0487B.b).
> 
> ARMv8.1 introduces the optional feature ARMv8.1-TTHM which can trigger a
> new type of memory abort. This exception is triggered when hardware update
> of page table flags is not atomic in regards to other memory accesses.
> Replace the corresponding unknown entry with a more accurate one.
> 
> Cf: Section D10.2.28 ESR_ELx, Exception Syndrome Register (p D10-2381),
> section D4.4.11 Restriction on memory types for hardware updates on page
> tables (p D4-2116 - D4-2117).
> 
> ARMv8.2 does not add new exception types, however it is worth mentioning
> that when obligatory feature RAS (optional for ARMv8.{0,1}) is implemented,
> exceptions related to "Synchronous parity or ECC error on memory access,
> not on translation table walk" become reserved and should not occur.
> 
> Cf: Section D10.2.28 ESR_ELx, Exception Syndrome Register (p D10-2381).
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>

I've queued this, but I dropped the end of your commit message because it
looks weirdly corrupted.

Will

> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
>  arch/arm64/mm/fault.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
