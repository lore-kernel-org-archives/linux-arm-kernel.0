From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Aug 2012 15:11:11 +0000
Subject: [PATCH v2 25/31] arm64: Performance counters support
In-Reply-To: <1344966752-16102-26-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-26-git-send-email-catalin.marinas@arm.com>
Message-ID: <201208151511.11612.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 August 2012, Catalin Marinas wrote:
> From: Will Deacon <will.deacon@arm.com>
> 
> This patch adds support for the AArch64 performance counters.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/include/asm/perf_event.h |   22 +
>  arch/arm64/include/asm/pmu.h        |   82 +++
>  arch/arm64/kernel/perf_event.c      | 1368 +++++++++++++++++++++++++++++++++++
>  tools/perf/perf.h                   |    6 +

Can you explain how AArch64 performance counters differ from the 32
bit ones? Do they work for AArch32 user space under AArch64 kernels?
Is it possible to share parts of the implementation with arch/arm?

	Arnd
