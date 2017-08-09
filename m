From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 9 Aug 2017 18:51:38 +0100
Subject: [PATCH 0/2] md/raid6: improvements for ARM/arm64
In-Reply-To: <20170713171601.25440-1-ard.biesheuvel@linaro.org>
References: <20170713171601.25440-1-ard.biesheuvel@linaro.org>
Message-ID: <20170809175137.hpj27jp2f4nen45g@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Thu, Jul 13, 2017 at 06:15:59PM +0100, Ard Biesheuvel wrote:
> 1. Use a faster algorithm for the delta syndrome
> 2. Implement recovery routines in NEON
> 
> As before, NEON intrinsics are used, which means the same code can be
> compiled for ARM as well as arm64.
> 
> Given that there does not seem to be a maintainer for lib/raid6, could
> we take this through one of the ARM trees instead?
> 
> Ard Biesheuvel (2):
>   md/raid6: use faster multiplication for ARM NEON delta syndrome
>   md/raid6: implement recovery using ARM NEON intrinsics
> 
>  include/linux/raid/pq.h      |   1 +
>  lib/raid6/Makefile           |   4 +-
>  lib/raid6/algos.c            |   3 +
>  lib/raid6/neon.uc            |  33 +++++-
>  lib/raid6/recov_neon.c       | 110 ++++++++++++++++++
>  lib/raid6/recov_neon_inner.c | 117 ++++++++++++++++++++

IIRC, you wanted these patches merged via the arm64 tree? I'll apply
them to the for-next/core branch.

-- 
Catalin
