From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 9 Oct 2015 13:50:53 +0100
Subject: [PATCHv3 0/7] arm64: Use contiguous PTE bit for the kernel
 linear mapping
In-Reply-To: <1444237225-13802-1-git-send-email-jeremy.linton@arm.com>
References: <1444237225-13802-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <20151009125052.GV17192@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2015 at 12:00:18PM -0500, Jeremy Linton wrote:
> Jeremy Linton (7):
>   arm64: Add contiguous page flag shifts and constants
>   arm64: PTE/PMD contiguous bit definition
>   arm64: Macros to check/set/unset the contiguous bit
>   arm64: Default kernel pages should be contiguous
>   arm64: Make the kernel page dump utility aware of the CONT bit
>   arm64: Add a kernel Kconfig option to enable contiguous PTE marking
>   arm64: Mark kernel page ranges contiguous

I queued the series without patch 6 (and a modification of patch 7 to
get rid of the config option check). If we need this option, we can add
it later but for (hardware) debugging purposes it looks to me like we
can simply set PTE_CONT to 0.

Thanks.

-- 
Catalin
